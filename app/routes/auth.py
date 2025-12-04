# app/routes/auth.py
from datetime import datetime
from typing import Optional

from fastapi import APIRouter, Body, Depends, Query, Path, HTTPException, status
from fastapi.security import OAuth2PasswordBearer

from app.db import get_db_connection
from app.models.api_response import SuccessResponse
from app.core.security import decode_access_token
import app.controllers.auth_controller as auth_controller

router = APIRouter(prefix="/auth", tags=["auth"])

# OAuth2 bearer scheme (Authorization: Bearer <token>)
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/auth/login")


def get_current_user(token: str = Depends(oauth2_scheme)) -> dict:
    """
    Decode token dan balikin dict user:
    {id, nama_lengkap, email, role}
    """
    payload = decode_access_token(token)
    user_id = payload.get("sub")
    name    = payload.get("name")
    email   = payload.get("email")
    role    = payload.get("role")

    if user_id is None or email is None or role is None:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail={"message": "Token payload tidak lengkap"},
        )

    return {
        "id": user_id,
        "nama_lengkap": name,
        "email": email,
        "role": role,
    }


def get_current_admin(current_user: dict = Depends(get_current_user)) -> dict:
    if current_user.get("role") != "admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail={"message": "Hanya admin yang boleh mengakses endpoint ini"},
        )
    return current_user


# ==================== AUTH ====================

@router.post("/login", response_model=SuccessResponse)
def login(
    email: str = Body(...),
    password: str = Body(...),
    db = Depends(get_db_connection),
):
    return auth_controller.AuthController.login(email, password, db)


@router.post("/register", response_model=SuccessResponse)
def register(
    nama_lengkap: str = Body(...),
    nomor_telepon: str = Body(...),
    alamat: str = Body(...),
    email: str = Body(...),
    password: str = Body(...),
    db = Depends(get_db_connection),
):
    return auth_controller.AuthController.register(
        nama_lengkap=nama_lengkap,
        nomor_telepon=nomor_telepon,
        alamat=alamat,
        email=email,
        role="tamu",
        password=password,
        db=db,
    )


@router.get("/me", response_model=SuccessResponse)
def get_me(current_user: dict = Depends(get_current_user)):
    return {
        "status": "success",
        "message": "Current user fetched",
        "data": current_user,
    }


@router.post("/logout", response_model=SuccessResponse)
def logout(
    db = Depends(get_db_connection),
    current_user: dict = Depends(get_current_user),
):
    return auth_controller.AuthController.logout(
        email=current_user["email"],
        db=db,
    )

# ==================== SESSION LOGIN (ADMIN ONLY) ====================

@router.get("/session_login", response_model=SuccessResponse)
def session_login(
    limit: int = Query(50, ge=0),
    offset: int = Query(0, ge=0),
    db = Depends(get_db_connection),
    current_admin: dict = Depends(get_current_admin),
):
    return auth_controller.AuthController.session_login(
        limit=limit,
        offset=offset,
        db=db,
    )


# ==================== RESERVASI ====================

@router.post("/reservasi", response_model=SuccessResponse)
def buat_reservasi(
    nomor_kamar: str = Body(...),
    waktu_checkin: datetime = Body(...),
    waktu_checkout: datetime = Body(...),
    tanggal_pembayaran: Optional[datetime] = Body(None),
    metode_pembayaran: Optional[str] = Body(None),
    db = Depends(get_db_connection),
    current_user: dict = Depends(get_current_user),
):
    return auth_controller.AuthController.reservasi(
        nama_lengkap=current_user["nama_lengkap"],
        nomor_kamar=nomor_kamar,
        waktu_checkin=waktu_checkin,
        waktu_checkout=waktu_checkout,
        tanggal_pembayaran=tanggal_pembayaran,
        metode_pembayaran=metode_pembayaran,
        db=db,
    )


@router.get("/reservasi", response_model=SuccessResponse)
def list_reservasi(
    limit: int = Query(50, ge=0),
    offset: int = Query(0, ge=0),
    status_reservasi: Optional[str] = Query(None),
    nomor_kamar: Optional[str] = Query(None),
    nama_lengkap: Optional[str] = Query(None),
    checkin_start: Optional[str] = Query(None),
    checkin_end: Optional[str] = Query(None),
    db = Depends(get_db_connection),
    current_user: dict = Depends(get_current_user),
):
    if current_user["role"] != "admin":
        nama_lengkap = current_user["nama_lengkap"]

    return auth_controller.AuthController.list_reservasi(
        db=db,
        limit=limit,
        offset=offset,
        nama_lengkap=nama_lengkap,
        nomor_kamar=nomor_kamar,
        status_reservasi=status_reservasi,
        checkin_start=checkin_start,
        checkin_end=checkin_end,
    )


@router.put("/reservasi/{id_reservasi}/checkin", response_model=SuccessResponse)
def status_reservasi_checkin(
    id_reservasi: int = Path(..., ge=1),
    db = Depends(get_db_connection),
    current_admin: dict = Depends(get_current_admin),
):
    return auth_controller.AuthController.status_reservasi_checkin(
        id_reservasi=id_reservasi,
        db=db,
    )


@router.put("/reservasi/{id_reservasi}/checkout", response_model=SuccessResponse)
def status_reservasi_checkout(
    id_reservasi: int = Path(..., ge=1),
    db = Depends(get_db_connection),
    current_admin: dict = Depends(get_current_admin),
):
    return auth_controller.AuthController.status_reservasi_checkout(
        id_reservasi=id_reservasi,
        db=db,
    )


@router.put("/reservasi/{nomor_kamar}/batal", response_model=SuccessResponse)
def status_reservasi_batal(
    nomor_kamar: str = Path(...),
    db = Depends(get_db_connection),
    current_user: dict = Depends(get_current_user),
):
    return auth_controller.AuthController.status_reservasi_batal(
        nama_lengkap=current_user["nama_lengkap"],
        nomor_kamar=nomor_kamar,
        db=db,
    )

# ==================== LAPORAN / MASTER DATA ====================

@router.get("/pendapatan", response_model=SuccessResponse)
def pendapatan_bulanan(
    db = Depends(get_db_connection),
    current_admin: dict = Depends(get_current_admin),
):
    return auth_controller.AuthController.pendapatan_bulanan(db)


@router.get("/katalog", response_model=SuccessResponse)
def katalog_kamar(
    db = Depends(get_db_connection),
    current_admin: dict = Depends(get_current_admin),
):
    return auth_controller.AuthController.katalog_kamar(db)


@router.get("/kamar", response_model=SuccessResponse)
def melihat_kamar(
    db = Depends(get_db_connection),
    current_user: dict = Depends(get_current_user),
):
    return auth_controller.AuthController.melihat_kamar(db)
