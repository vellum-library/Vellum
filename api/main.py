import os
import psycopg

from fastapi import FastAPI
from fastapi.responses import JSONResponse

app = FastAPI(
    title="Vellum API",
    description="API para la gestion de libros electronicos",
    version="1.0.0"
)


def get_db_connection():
    return psycopg.connect(
        host=os.environ["DB_HOST"],
        port=os.environ["DB_PORT"],
        dbname=os.environ["DB_NAME"],
        user=os.environ["DB_USER"],
        password=os.environ["DB_PASSWORD"]
    )


@app.get("/")
def inicio():
    return {
        "mensaje": "Bienvenido a Vellum API"
    }


@app.get("/health")
def health():
    try:
        conn = get_db_connection()
        conn.close()

        return {
            "servicio": "Vellum API",
            "base_de_datos": "Conectada"
        }

    except psycopg.Error:
        return JSONResponse(
            status_code=503,
            content={
                "servicio": "Vellum API",
                "base_de_datos": "Error de conexion"
            }
        )