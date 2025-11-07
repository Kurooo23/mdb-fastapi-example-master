from typing import Optional, Any
from fastapi import FastAPI, Depends, HTTPException, status, Body
from pydantic import BaseModel
from app.db import get_db_connection

app = FastAPI(title="MBD Praktikum FastApi Backend")

class SuccessResponse(BaseModel):
    status: str = "success"
    message: str
    data: Optional[Any] = None

class ErrorResponse(BaseModel):
    status: str = "error"
    message: str
    detail: Optional[Any] = None

@app.get("/health")
async def health_check():
    return {"status": "ok"}

@app.get("/")
async def root():
    return {"message": "Hello, World!"}

@app.post("/login", response_model=SuccessResponse)
async def login(
    email: str = Body(...),
    password: str = Body(...),
    db=Depends(get_db_connection),
):
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
