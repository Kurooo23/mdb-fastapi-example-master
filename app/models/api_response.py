# app/models/api_response.py
from datetime import datetime
from pydantic import BaseModel, EmailStr 
from typing import Optional, Any, List

class SessionLogin(BaseModel):
    id_user: int
    nama_lengkap: str
    waktu_login: datetime

class SuccessListResponse(BaseModel):
    status: str = "success"
    message: str = "OK"
    data: List[SessionLogin]

class SuccessResponse(BaseModel):
    status: str = "success"
    message: str
    data: Optional[Any] = None

class ErrorResponse(BaseModel):
    status: str = "error"
    message: str
    detail: Optional[Any] = None

class LogoutRequest(BaseModel):
    email: EmailStr

# Tambahan: payload token yang dikirim ke client
class TokenPayload(BaseModel):
    access_token: str
    token_type: str = "bearer"
    expires_in: int
    user: dict  # {id, name, email, role}
