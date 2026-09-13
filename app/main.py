from fastapi import FastAPI
from datetime import datetime

app = FastAPI()

VERSION = "1.0.0"

@app.get("/")
def mensaje_de_inicio():
    return {
        "mensaje": "API básica para hacer CI/CD en Cloud Run"
    }

@app.get("/estado")
def estado_de_la_api():
    return {
        "estado": "En funcionamiento"
    }

@app.get("/info")
def info_de_la_api():
    return {
        "version": VERSION, "hora_actual": datetime.now().isoformat()
    }