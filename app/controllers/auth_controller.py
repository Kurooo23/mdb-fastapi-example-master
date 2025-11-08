from fastapi import APIRouter, Body, Depends, HTTPException, status
from pymysql import OperationalError
from app.db import get_db_connection
from app.models.api_response import ErrorResponse
from app.models.api_response import SuccessResponse, ErrorResponse

class AuthController:
    @staticmethod
    async def login(email: str, password: str, db):
        # db di sini SUDAH berupa koneksi (karena dependency yield)
        with db.cursor() as cursor:
            cursor.execute("CALL sp_login_user(%s, %s);", (email, password))
            row = cursor.fetchone()
            # bersihkan sisa result set dari CALL
            while cursor.nextset():
                pass

        if not row:
            err = ErrorResponse(message="Login failed (empty SP result)")
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=err.dict())

        if row.get("status") != "OK":
            err = ErrorResponse(message="Login failed", detail=row.get("message"))
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail=err.dict())

        # mapping kolom sesuai hasil SP
        user = {
            "id":    row["id_user"],
            "name":  row["nama_lengkap"],
            "role":  row["role"],
            "email": row["email"],
        }

        return {
            "message": "Login successful",
            "data": {"user": user},
        }
    
    @staticmethod
    async def register(
        nama_lengkap: str,
        nomor_telepon: str,
        alamat: str,
        email: str,
        role: str,
        password: str,
        db,
    ):
        try:
        # db di sini SUDAH berupa koneksi (karena dependency yield)
            with db.cursor() as cursor:
                cursor.execute(
                    "CALL registrasi(%s, %s, %s, %s, %s, %s);",
                    (nama_lengkap, nomor_telepon, alamat, email, role, password),
                )
                row = cursor.fetchone()
                # bersihkan sisa result set dari CALL
                while cursor.nextset():
                    pass

            if not row:
                err = ErrorResponse(message="Registration failed (empty SP result)")
                raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=err.dict())

            # if row.get("id_user_tamu"):
            #     err = ErrorResponse(message="Registration failed", detail=row.get("message"))
            #     raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=err.dict())
            return {
                "message": "Registration successful",
                "data": {"user_id": row.get("id_user_baru")},
            }
        
        except OperationalError as e:
            err = ErrorResponse(message="Registration failed", detail=str(e))
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=err.dict())