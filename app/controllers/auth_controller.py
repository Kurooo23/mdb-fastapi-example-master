from __future__ import annotations
from fastapi import APIRouter, Body, Depends, HTTPException, status
from pymysql import OperationalError, IntegrityError, ProgrammingError, MySQLError
from app.db import get_db_connection
from app.models.api_response import SuccessResponse, ErrorResponse
from datetime import datetime
from typing import Optional, Any, List, Union, Dict
from decimal import Decimal
from app.core.security import create_access_token, ACCESS_TOKEN_EXPIRE_MINUTES


class AuthController:
    @staticmethod
    def login(email: str, password: str, db):
        with db.cursor() as cursor:
            cursor.execute("CALL sp_login_user(%s, %s);", (email, password))
            row = cursor.fetchone()
            while cursor.nextset():
                pass

        if not row:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail={"message": "Login failed (empty SP result)"}
            )

        status_sp = row.get("status")
        if status_sp == "ALREADY_LOGGED_IN":
            raise HTTPException(
                status_code=status.HTTP_409_CONFLICT,
                detail={"message": "User already has an active session"},
            )
        if status_sp != "OK":
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail={"message": "Login failed", "detail": row.get("message")},
            )

        user = {
            "id":    row["id_user"],
            "name":  row["nama_lengkap"],
            "role":  row["role"],
            "email": row["email"],
        }

        # === BAGIAN BARU: generate JWT ===
        claims = {
            "sub": user["id"],
            "email": user["email"],
            "name": user["name"],
            "role": user["role"],
        }
        access_token = create_access_token(claims)

        return {
            "message": "Login successful",
            "data": {
                "access_token": access_token,
                "token_type": "bearer",
                "expires_in": ACCESS_TOKEN_EXPIRE_MINUTES * 60,
                "user": user,
            },
        }

    @staticmethod
    def register(
        nama_lengkap: str,
        nomor_telepon: str,
        alamat: str,
        email: str,
        role: str,
        password: str,
        db,
    ):
        try:
            with db.cursor() as cursor:
                cursor.execute(
                    "CALL sp_registrasi(%s, %s, %s, %s, %s, %s);",
                    (nama_lengkap, nomor_telepon, alamat, email, role, password),
                )
                row = cursor.fetchone()
                while cursor.nextset():
                    pass

            if not row:
                raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                                    detail={"message": "Registration failed (empty SP result)"})

            return {
                "message": "Registration successful",
                "data": {
                    "user_id": row.get("id_user_baru"),
                    "nama_lengkap": row.get("nama"),
                    "email": row.get("email"),
                    "password": row.get("password"),
                    "ROLE": row.get("ROLE"),
                    "alamat": row.get("alamat"),
                    "nomor_telepon": row.get("nomor_telepon"),
                },
            }
        except OperationalError as e:
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                                detail={"message": "Registration failed", "detail": str(e)})

    @staticmethod
    def session_login(
        limit: int,
        offset: int,
        db,
    ):
        """SP tanpa parameter → paging saja di layer API."""
        try:
            with db.cursor() as cursor:
                cursor.execute("CALL sp_v_session_login();")
                rows = cursor.fetchall() or []
                while cursor.nextset():
                    pass
        except OperationalError as e:
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                                detail={"message": "Failed to fetch session login", "detail": str(e)})

        try:
            limit = int(limit); offset = int(offset)
        except (TypeError, ValueError):
            raise HTTPException(status_code=400,
                                detail={"message": "Invalid limit/offset", "detail": "limit/offset must be integers"})
        if limit < 0 or offset < 0:
            raise HTTPException(status_code=400,
                                detail={"message": "Invalid pagination", "detail": "limit/offset must be non-negative"})

        total = len(rows)
        items = rows[offset: offset + limit] if limit else rows[offset:]

        return {"message": "Session login fetched",
                "data": {"items": items, "meta": {"total": total, "limit": limit, "offset": offset}}}

    @staticmethod
    def logout(email: str, db):
        with db.cursor() as cursor:
            cursor.execute("CALL sp_logout_user(%s);", (email,))
            row = cursor.fetchone()
            while cursor.nextset():
                pass

        if not row:
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                                detail={"message": "Logout failed (empty SP result)"})

        status_sp = row.get("status", "")
        msg = row.get("message")

        if status_sp == "INVALID_EMAIL":
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST,
                                detail={"message": "Logout failed", "detail": msg})
        if status_sp in ("NO_ACTIVE_SESSION", "ALREADY_LOGGED_OUT"):
            raise HTTPException(status_code=status.HTTP_409_CONFLICT,
                                detail={"message": "User has no active session", "detail": msg})
        if status_sp != "OK":
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                                detail={"message": "Logout failed", "detail": msg})

        return {"message": "Logout successful"}

    @staticmethod
    def reservasi(
        nama_lengkap: str,
        nomor_kamar: str,
        waktu_checkin: Union[str, datetime],
        waktu_checkout: Union[str, datetime],
        tanggal_pembayaran: Optional[Union[str, datetime]],
        metode_pembayaran: Optional[str],
        db
    ):
        def _to_dt(x):
            if x is None: return None
            return x if isinstance(x, datetime) else datetime.fromisoformat(str(x))

        dt_checkin  = _to_dt(waktu_checkin)
        dt_checkout = _to_dt(waktu_checkout)
        dt_bayar    = _to_dt(tanggal_pembayaran)

        try:
            with db.cursor() as cursor:
                cursor.execute(
                    "CALL sp_buat_reservasi(%s, %s, %s, %s, %s, %s);",
                    (nama_lengkap, nomor_kamar, dt_checkin, dt_checkout, dt_bayar, metode_pembayaran),
                )
                row = cursor.fetchone()
                while cursor.nextset():
                    pass

            if not row:
                raise HTTPException(
                    status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                    detail={"message": "Reservation failed (SP returned no row)"}
                )

            return {
                "message": "Reservation successful",
                "data": {
                    "id_reservasi": row.get("id_reservasi"),
                    "nama_lengkap": row.get("nama_lengkap"),
                    "nomor_kamar": row.get("nomor_kamar"),
                    "waktu_checkin": row.get("waktu_checkin"),
                    "waktu_checkout": row.get("waktu_checkout"),
                    "tanggal_pembayaran": row.get("tanggal_pembayaran"),
                    "metode_pembayaran": row.get("metode_pembayaran"),
                    "status": row.get("status"),
                    "total_biaya": float(row["total_biaya"]) if row.get("total_biaya") is not None else None,
                },
            }

        except IntegrityError as e:
            raise HTTPException(status_code=400, detail={"message": "Integrity error", "detail": str(e)})
        except MySQLError as e:
            errno = e.args[0] if e.args else None
            msg   = e.args[1] if len(e.args) > 1 else str(e)
            if errno == 1644:
                raise HTTPException(status_code=400, detail={"message": msg})
            raise HTTPException(status_code=500, detail={"message": "Database error", "detail": str(e)})
        except (OperationalError, ProgrammingError) as e:
            raise HTTPException(status_code=500, detail={"message": "Failed to execute stored procedure", "detail": str(e)})


    @staticmethod
    def list_reservasi(
        db,
        *,
        limit: int = 0,
        offset: int = 0,
        nama_lengkap: Optional[str] = None,
        nomor_kamar:  Optional[str] = None,
        status_reservasi: Optional[str] = None,
        checkin_start: Optional[str] = None,
        checkin_end:   Optional[str] = None,
    ) -> Dict[str, Any]:
        try:
            limit = int(limit); offset = int(offset)
        except (TypeError, ValueError):
            raise HTTPException(status_code=400, detail={"message": "limit/offset harus integer"})
        if limit < 0 or offset < 0:
            raise HTTPException(status_code=400, detail={"message": "limit/offset tidak boleh negatif"})

        def _to_dt(x: Optional[str]) -> Optional[datetime]:
            if not x: return None
            try: return datetime.fromisoformat(str(x))
            except ValueError:
                raise HTTPException(status_code=422, detail={"message": f"Format tanggal tidak valid: {x}"})

        s_dt = _to_dt(checkin_start)
        e_dt = _to_dt(checkin_end)

        try:
            with db.cursor() as cur:
                cur.execute("CALL sp_v_reservasi_detail();")
                rows: List[Dict[str, Any]] = cur.fetchall() or []
                while cur.nextset():
                    pass
        except (OperationalError, ProgrammingError, MySQLError) as e:
            errno = getattr(e, "args", [None])[0]
            msg = getattr(e, "args", [None, ""])[1] if len(getattr(e, "args", [])) > 1 else str(e)
            if errno == 1644:
                raise HTTPException(status_code=400, detail={"message": msg})
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                                detail={"message": "Database error", "detail": str(e)})

        if nama_lengkap:
            q = nama_lengkap.lower()
            rows = [r for r in rows if r.get("nama_lengkap") and q in r["nama_lengkap"].lower()]
        if nomor_kamar:
            q = str(nomor_kamar).lower()
            rows = [r for r in rows if r.get("nomor_kamar") and q in str(r["nomor_kamar"]).lower()]
        if status_reservasi:
            rows = [r for r in rows if r.get("status") == status_reservasi]

        if s_dt or e_dt:
            def in_range(r: Dict[str, Any]) -> bool:
                wci = r.get("waktu_checkin")
                if not wci: return False
                if isinstance(wci, str):
                    try: wci = datetime.fromisoformat(wci)
                    except ValueError: return False
                if s_dt and wci < s_dt: return False
                if e_dt and wci > e_dt: return False
                return True
            rows = [r for r in rows if in_range(r)]

        def _key(r: Dict[str, Any]):
            t = r.get("waktu_checkin")
            if isinstance(t, str):
                try: t = datetime.fromisoformat(t)
                except ValueError: t = datetime.min
            return (t or datetime.min, r.get("id_reservasi") or 0)

        rows.sort(key=_key, reverse=True)
        total = len(rows)
        items = rows if limit == 0 else rows[offset: offset + limit]

        for r in items:
            if "total_biaya" in r and r["total_biaya"] is not None:
                try: r["total_biaya"] = float(r["total_biaya"])
                except Exception: pass

        return {
            "message": "Reservasi fetched",
            "data": {
                "items": items,
                "meta": {
                    "total": total,
                    "limit": limit,
                    "offset": offset,
                },
            },
        }

    @staticmethod
    def list_by_nama(
        db,
        nama_lengkap: str,
        limit: int = 0,
        offset: int = 0,
    ) -> Dict[str, Any]:
        if not nama_lengkap or not str(nama_lengkap).strip():
            raise HTTPException(status_code=400, detail={"message": "nama_lengkap wajib diisi"})

        try:
            limit = int(limit); offset = int(offset)
        except (TypeError, ValueError):
            raise HTTPException(status_code=400, detail={"message": "limit/offset harus integer"})
        if limit < 0 or offset < 0:
            raise HTTPException(status_code=400, detail={"message": "limit/offset tidak boleh negatif"})

        try:
            with db.cursor() as cur:
                cur.execute("CALL sp_v_riwayat_reservasi_by_nama(%s);", (nama_lengkap.strip(),))
                rows: List[Dict[str, Any]] = cur.fetchall() or []
                while cur.nextset():
                    pass
        except (OperationalError, ProgrammingError, MySQLError) as e:
            errno = getattr(e, "args", [None])[0]
            msg   = getattr(e, "args", [None, ""])[1] if len(getattr(e, "args", [])) > 1 else str(e)
            if errno == 1644:
                raise HTTPException(status_code=400, detail={"message": msg})
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                                detail={"message": "Database error", "detail": str(e)})

        def _key(r: Dict[str, Any]):
            t = r.get("waktu_checkin")
            if isinstance(t, str):
                try: t = datetime.fromisoformat(t)
                except ValueError: t = datetime.min
            return (t or datetime.min, r.get("id_reservasi") or 0)

        rows.sort(key=_key, reverse=True)
        total = len(rows)
        items = rows if limit == 0 else rows[offset: offset + limit]

        for r in items:
            if "total_biaya" in r and r["total_biaya"] is not None:
                try: r["total_biaya"] = float(r["total_biaya"])
                except Exception: pass

        return {
            "message": "Riwayat reservasi fetched",
            "data": {
                "items": items,
                "meta": {"total": total, "limit": limit, "offset": offset, "filters": {"nama_lengkap": nama_lengkap}},
            },
        }
    
    @staticmethod
    def status_reservasi_checkin(
        id_reservasi: int,
        status_baru: str,
        db,
    ):
        # Validasi input
        if not isinstance(id_reservasi, int) or id_reservasi <= 0:
            raise HTTPException(status_code=400, detail={"message": "id_reservasi tidak valid"})

        if not status_baru or status_baru.lower() != "checkin":
            raise HTTPException(status_code=400, detail={"message": "Hanya mendukung checkin"})

        try:
            with db.cursor() as cursor:
                # === KHUSUS CHECKIN ===
                cursor.execute("CALL sp_checkin_reservasi(%s);", (id_reservasi,))

                # Ambil baris dari result set terakhir yang tidak kosong
                row = cursor.fetchone()
                while cursor.nextset():
                    r = cursor.fetchone()
                    if r is not None:
                        row = r

            # Commit jika koneksi tidak autocommit
            try:
                db.commit()
            except Exception:
                pass

        except (OperationalError, ProgrammingError, MySQLError) as e:
            errno = getattr(e, "args", [None])[0]
            msg   = getattr(e, "args", [None, ""])[1] if len(getattr(e, "args", [])) > 1 else str(e)
            if errno == 1644:  # SIGNAL '45000'
                raise HTTPException(status_code=400, detail={"message": msg})
            raise HTTPException(status_code=500, detail={"message": "Database error", "detail": str(e)})

        if not row:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail={"message": "Check-in gagal (SP tidak mengembalikan baris)"}
            )

        # Normalisasi supaya JSON-serializable
        def _to_iso(x):
            if isinstance(x, datetime):
                return x.isoformat(sep=" ")
            return x

        for k in ("waktu_checkin", "waktu_checkout", "tanggal_pembayaran", "created_at", "updated_at"):
            if k in row and row[k] is not None:
                row[k] = _to_iso(row[k])

        for k in ("total_biaya", "harga_per_malam", "amount", "nominal"):
            if k in row and isinstance(row[k], Decimal):
                row[k] = float(row[k])

        return {
            "message": "Reservasi berhasil check-in",
            "data": row
        }
    
    @staticmethod
    def status_reservasi_checkout(
        id_reservasi: int,
        db,
    ):
        # Validasi input
        if not isinstance(id_reservasi, int) or id_reservasi <= 0:
            raise HTTPException(status_code=400, detail={"message": "id_reservasi tidak valid"})

        try:
            with db.cursor() as cursor:
                cursor.execute("CALL sp_checkout_reservasi(%s);", (id_reservasi,))

                # Ambil baris dari result set terakhir yang tidak kosong (kalau SP menghasilkan beberapa result set)
                row = cursor.fetchone()
                while cursor.nextset():
                    r = cursor.fetchone()
                    if r is not None:
                        row = r

            # Commit jika koneksi tidak autocommit
            try:
                db.commit()
            except Exception:
                pass

        except (OperationalError, ProgrammingError, MySQLError) as e:
            errno = getattr(e, "args", [None])[0]
            msg   = getattr(e, "args", [None, ""])[1] if len(getattr(e, "args", [])) > 1 else str(e)
            # 1644 = SIGNAL SQLSTATE '45000' dari MySQL
            if errno == 1644:
                raise HTTPException(status_code=400, detail={"message": msg})
            raise HTTPException(status_code=500, detail={"message": "Database error", "detail": str(e)})

        if not row:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail={"message": "Checkout gagal (SP tidak mengembalikan baris)"}
            )

        # Normalisasi supaya JSON-serializable
        def _to_iso(x):
            if isinstance(x, datetime):
                return x.isoformat(sep=" ")
            return x

        for k in ("waktu_checkin", "waktu_checkout", "tanggal_pembayaran", "created_at", "updated_at"):
            if k in row and row[k] is not None:
                row[k] = _to_iso(row[k])

        for k in ("total_biaya", "harga_per_malam", "amount", "nominal"):
            if k in row and isinstance(row[k], Decimal):
                row[k] = float(row[k])

        return {
            "message": "Reservasi berhasil checkout",
            "data": row
        }
    
    @staticmethod
    def status_reservasi_batal(
        nama_lengkap: str,
        nomor_kamar: str,
        db,
    ):
        try:
            with db.cursor() as cursor:
                cursor.execute(
                    "CALL sp_membatalkan_reservasi(%s, %s);",
                    (nama_lengkap, nomor_kamar),
                )
                row = cursor.fetchone()
                while cursor.nextset():
                    pass

            if not row:
                raise HTTPException(
                    status_code=500,
                    detail={"message": "Pembatalan reservasi gagal (SP tidak mengembalikan baris)"}
                )

            return {
                "message": "Reservasi berhasil dibatalkan",
                "data": row,
            }


        except (OperationalError, ProgrammingError, MySQLError) as e:
            errno = getattr(e, "args", [None])[0]
            msg   = getattr(e, "args", [None, ""])[1] if len(getattr(e, "args", [])) > 1 else str(e)
            if errno == 1644:  # SIGNAL '45000'
                raise HTTPException(status_code=400, detail={"message": msg})
            raise HTTPException(status_code=500, detail={"message": "Database error", "detail": str(e)})
        
    @staticmethod
    def pendapatan_bulanan(
        db,
    ):
        try:
            with db.cursor() as cursor:
                cursor.execute("CALL sp_v_pendapatan_bulanan();")
                rows: List[Dict[str, Any]] = cursor.fetchall() or []
                while cursor.nextset():
                    pass
        except (OperationalError, ProgrammingError, MySQLError) as e:
            errno = getattr(e, "args", [None])[0]
            msg   = getattr(e, "args", [None, ""])[1] if len(getattr(e, "args", [])) > 1 else str(e)
            if errno == 1644:
                raise HTTPException(status_code=400, detail={"message": msg})
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail={"message": "Database error", "detail": str(e)},
            )

        return {
            "message": "Pendapatan bulanan fetched",
            "data": rows,
        }
    
    @staticmethod
    def katalog_kamar(
        db,
    ):
        try:
            with db.cursor() as cursor:
                cursor.execute("CALL sp_v_menampilkan_katalog_kategori();")
                rows: List[Dict[str, Any]] = cursor.fetchall() or []
                while cursor.nextset():
                    pass
        except (OperationalError, ProgrammingError, MySQLError) as e:
            errno = getattr(e, "args", [None])[0]
            msg   = getattr(e, "args", [None, ""])[1] if len(getattr(e, "args", [])) > 1 else str(e)
            if errno == 1644:
                raise HTTPException(status_code=400, detail={"message": msg})
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                                detail={"message": "Database error", "detail": str(e)})

        for r in rows:
            if "harga_per_malam" in r and isinstance(r["harga_per_malam"], Decimal):
                r["harga_per_malam"] = float(r["harga_per_malam"])

        return {
            "message": "Katalog kamar fetched",
            "data": rows,
        }
    
    @staticmethod
    def melihat_kamar(
        db,
    ):
        try:
            with db.cursor() as cursor:
                # panggil stored procedure
                cursor.execute("CALL sp_v_melihat_kamar();")
                rows: List[Dict[str, Any]] = cursor.fetchall() or []

                # buang result-set sisa kalau ada
                while cursor.nextset():
                    pass

        except (OperationalError, ProgrammingError, MySQLError) as e:
            errno = getattr(e, "args", [None])[0]
            msg   = getattr(e, "args", [None, ""])[1] if len(getattr(e, "args", [])) > 1 else str(e)

            # 1644 = SIGNAL SQLSTATE '45000'
            if errno == 1644:
                raise HTTPException(status_code=400, detail={"message": msg})

            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail={"message": "Database error", "detail": str(e)},
            )

        # konversi Decimal -> float biar aman di JSON
        for r in rows:
            if "harga_per_malam" in r and isinstance(r["harga_per_malam"], Decimal):
                r["harga_per_malam"] = float(r["harga_per_malam"])

        return {
            "message": "Kamar tersedia fetched",
            "data": rows,
        }