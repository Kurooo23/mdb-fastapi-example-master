from fastapi import APIRouter, Body, Depends, HTTPException, status
import pymysql
from app.db import get_db_connection
from app.models.api_response import SuccessResponse, ErrorResponse
from pymysql.err import OperationalError
import app.controllers.auth_controller as auth_controller

router = APIRouter(prefix="/auth", tags=["auth"])


@router.post("/login", response_model=SuccessResponse)
async def login(
    email: str = Body(...),
    password: str = Body(...),
    db=Depends(get_db_connection),
):
    return await auth_controller.AuthController.login(email, password, db)
    
@router.post("/register", response_model=SuccessResponse)
async def register(
    nama_lengkap: str = Body(...),
    nomor_telepon: str = Body(...),
    alamat: str = Body(...),
    email: str = Body(...),
    role: str = Body(...),
    password: str = Body(...),
    db=Depends(get_db_connection),
):
    return await auth_controller.AuthController.register(nama_lengkap, alamat=alamat, nomor_telepon=nomor_telepon, email=email, role=role, password=password, db=db)
