# app/db.py
import os
import pymysql
from pymysql.cursors import DictCursor
from dotenv import load_dotenv

load_dotenv()

DB_HOST = os.getenv("DB_HOST", "127.0.0.1")
DB_PORT = int(os.getenv("DB_PORT", 3306))
DB_NAME = os.getenv("DB_NAME", "pemesanan_kamar_hotel")
DB_USER = os.getenv("DB_USER", "root")
DB_PASSWORD = os.getenv("DB_PASSWORD", "")

def get_db_connection():
    """FastAPI dependency: yield a PyMySQL connection and close it after the request."""
    conn = pymysql.connect(
        host=DB_HOST,
        port=DB_PORT,
        user=DB_USER,
        password=DB_PASSWORD,
        database=DB_NAME,
        cursorclass=DictCursor,
        charset="utf8mb4",
        autocommit=True,  # aman untuk CALL/SELECT; hapus jika Anda ingin commit manual
    )
    try:
        yield conn
    finally:
        conn.close()
