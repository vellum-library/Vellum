import os
import psycopg
import requests

from flask import Flask, jsonify

app = Flask(__name__)
app.secret_key = os.environ["SECRET_KEY"]

API_URL = os.environ["API_URL"]


def get_db_connection():
    return psycopg.connect(
        host=os.environ["DB_HOST"],
        port=os.environ["DB_PORT"],
        dbname=os.environ["DB_NAME"],
        user=os.environ["DB_USER"],
        password=os.environ["DB_PASSWORD"]
    )


@app.route("/")
def inicio():
    return "Vellum - Biblioteca Digital"


@app.route("/health")
def health():
    database_status = "Conectada"
    api_status = "Conectada"

    try:
        conn = get_db_connection()
        conn.close()
    except psycopg.Error:
        database_status = "Error de conexion"

    try:
        response = requests.get(
            f"{API_URL}/health",
            timeout=5
        )
        response.raise_for_status()
    except requests.RequestException:
        api_status = "Error de conexion"

    healthy = (
        database_status == "Conectada"
        and api_status == "Conectada"
    )

    return jsonify({
        "servicio": "Vellum WebApp",
        "base_de_datos": database_status,
        "api": api_status
    }), 200 if healthy else 503