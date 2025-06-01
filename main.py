from sentence_transformers import SentenceTransformer
import torch
from fastapi import FastAPI, HTTPException, status
from fastapi.responses import JSONResponse
from datetime import datetime


def greeting(idx: int, name: str):
    print(f"[{idx}]hello, {name}".title())


def main():
    for idx, name in enumerate(["james", "subscriber", "other"], start=1):
        greeting(id=idx, name=name)


if __name__ == "__main__":
    main()
