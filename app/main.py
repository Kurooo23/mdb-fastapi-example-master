from typing import Optional, Any
from fastapi import FastAPI, Depends, HTTPException, status, Body
from pydantic import BaseModel
from app.db import get_db_connection
# from mysql.connector import errors
from pymysql import OperationalError
from app.models.api_response import SuccessResponse, ErrorResponse
from app.routes.auth import router as auth_router
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(title="MBD Praktikum FastApi Backend")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/health")
async def health_check():
    return {"status": "ok"}

@app.get("/")
async def root():
    return {"message": "Hello, World!"}

app.include_router(auth_router)