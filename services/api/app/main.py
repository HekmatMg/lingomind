from __future__ import annotations

import hashlib
import hmac
import json
import os
import secrets
import time
import uuid
from typing import Any

from fastapi import FastAPI, Header, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, EmailStr, Field

APP_VERSION = "1.1.0"
TOKEN_TTL_SECONDS = 60 * 60 * 24 * 7
ENVIRONMENT = os.getenv("LINGOMIND_ENV", "development").strip().lower()
_configured_secret = os.getenv("LINGOMIND_TOKEN_SECRET")
if ENVIRONMENT == "production" and (not _configured_secret or len(_configured_secret) < 32):
    raise RuntimeError("LINGOMIND_TOKEN_SECRET must be set to a random value of at least 32 characters in production.")
TOKEN_SECRET = _configured_secret or secrets.token_urlsafe(48)

app = FastAPI(title="LingoMind API", version=APP_VERSION)
app.add_middleware(
    CORSMiddleware,
    allow_origins=[origin.strip() for origin in os.getenv("LINGOMIND_ALLOWED_ORIGINS", "http://localhost:3000").split(",") if origin.strip()],
    allow_credentials=True,
    allow_methods=["GET", "POST", "OPTIONS"],
    allow_headers=["Authorization", "Content-Type", "Idempotency-Key", "X-Request-ID"],
)

users: dict[str, dict[str, Any]] = {}
sessions: dict[str, dict[str, Any]] = {}
processed_turns: dict[str, dict[str, Any]] = {}
revoked_tokens: set[str] = set()


class RegisterRequest(BaseModel):
    email: EmailStr
    password: str = Field(min_length=10, max_length=128)
    name: str = Field(min_length=1, max_length=80)


class LoginRequest(BaseModel):
    email: EmailStr
    password: str = Field(min_length=1, max_length=128)


class SessionCreateRequest(BaseModel):
    scenario_id: str = Field(min_length=1, max_length=100)


class TurnRequest(BaseModel):
    text: str = Field(min_length=1, max_length=2000)


class UserProfile(BaseModel):
    id: str
    email: str
    name: str
    level: str
    streak: int


def _password_hash(password: str, salt: bytes | None = None) -> str:
    salt = salt or secrets.token_bytes(16)
    digest = hashlib.pbkdf2_hmac("sha256", password.encode(), salt, 310_000)
    return f"{salt.hex()}${digest.hex()}"


def _password_ok(password: str, stored: str) -> bool:
    try:
        salt_hex, digest_hex = stored.split("$", 1)
        salt = bytes.fromhex(salt_hex)
        expected = bytes.fromhex(digest_hex)
        actual = hashlib.pbkdf2_hmac("sha256", password.encode(), salt, 310_000)
        return hmac.compare_digest(actual, expected)
    except (ValueError, TypeError):
        return False


def _token(user_id: str) -> str:
    payload = {"sub": user_id, "jti": str(uuid.uuid4()), "exp": int(time.time()) + TOKEN_TTL_SECONDS}
    raw = json.dumps(payload, separators=(",", ":"), sort_keys=True).encode()
    encoded = raw.hex()
    signature = hmac.new(TOKEN_SECRET.encode(), raw, hashlib.sha256).hexdigest()
    return f"{encoded}.{signature}"


def _current_user(authorization: str | None) -> dict[str, Any]:
    if not authorization or not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail={"code": "unauthenticated", "message": "Authentication required."})
    token = authorization[7:].strip()
    try:
        encoded, signature = token.split(".", 1)
        raw = bytes.fromhex(encoded)
        expected = hmac.new(TOKEN_SECRET.encode(), raw, hashlib.sha256).hexdigest()
        if not hmac.compare_digest(signature, expected):
            raise ValueError
        payload = json.loads(raw)
        user_id = payload["sub"]
        jti = payload["jti"]
        if not isinstance(jti, str) or jti in revoked_tokens:
            raise ValueError
        if int(payload["exp"]) < int(time.time()) or user_id not in users:
            raise ValueError
        return users[user_id]
    except (ValueError, KeyError, TypeError, json.JSONDecodeError):
        raise HTTPException(status_code=401, detail={"code": "invalid_token", "message": "Invalid or expired token."}) from None


def _token_jti(authorization: str | None) -> str:
    if not authorization or not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail={"code": "unauthenticated", "message": "Authentication required."})
    try:
        encoded, signature = authorization[7:].strip().split(".", 1)
        raw = bytes.fromhex(encoded)
        expected = hmac.new(TOKEN_SECRET.encode(), raw, hashlib.sha256).hexdigest()
        if not hmac.compare_digest(signature, expected):
            raise ValueError
        payload = json.loads(raw)
        return str(payload["jti"])
    except (ValueError, KeyError, TypeError, json.JSONDecodeError):
        raise HTTPException(status_code=401, detail={"code": "invalid_token", "message": "Invalid token."}) from None


@app.middleware("http")
async def request_id_middleware(request: Request, call_next):
    request_id = request.headers.get("X-Request-ID") or str(uuid.uuid4())
    response = await call_next(request)
    response.headers["X-Request-ID"] = request_id
    return response


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok", "version": APP_VERSION}


@app.post("/v1/auth/register", response_model=UserProfile)
def register(payload: RegisterRequest):
    email = str(payload.email).strip().lower()
    if email in (u["email"] for u in users.values()):
        raise HTTPException(status_code=409, detail={"code": "email_exists", "message": "An account already exists."})
    user_id = str(uuid.uuid4())
    users[user_id] = {"id": user_id, "email": email, "name": payload.name.strip(), "password": _password_hash(payload.password), "level": "A2", "streak": 0, "sessions": []}
    return UserProfile(id=user_id, email=email, name=users[user_id]["name"], level="A2", streak=0)


@app.post("/v1/auth/login")
def login(payload: LoginRequest):
    email = str(payload.email).strip().lower()
    user = next((u for u in users.values() if u["email"] == email), None)
    if not user or not _password_ok(payload.password, user["password"]):
        raise HTTPException(status_code=401, detail={"code": "invalid_credentials", "message": "Email or password is incorrect."})
    return {"access_token": _token(user["id"]), "token_type": "Bearer", "expires_in": TOKEN_TTL_SECONDS}


@app.post("/v1/auth/logout")
def logout(authorization: str | None = Header(default=None)):
    _current_user(authorization)
    revoked_tokens.add(_token_jti(authorization))
    return {"logged_out": True}


@app.get("/v1/me", response_model=UserProfile)
def me(authorization: str | None = Header(default=None)):
    user = _current_user(authorization)
    return UserProfile(id=user["id"], email=user["email"], name=user["name"], level=user["level"], streak=user["streak"])


@app.post("/v1/sessions")
def create_session(payload: SessionCreateRequest, authorization: str | None = Header(default=None)):
    user = _current_user(authorization)
    session_id = str(uuid.uuid4())
    sessions[session_id] = {"id": session_id, "user_id": user["id"], "scenario_id": payload.scenario_id, "turns": [], "completed": False}
    user["sessions"].append(session_id)
    return {"session_id": session_id, "scenario_id": payload.scenario_id, "status": "active"}


@app.post("/v1/sessions/{session_id}/turns")
def add_turn(session_id: str, payload: TurnRequest, authorization: str | None = Header(default=None), idempotency_key: str | None = Header(default=None, alias="Idempotency-Key")):
    user = _current_user(authorization)
    session = sessions.get(session_id)
    if not session or session["user_id"] != user["id"]:
        raise HTTPException(status_code=404, detail={"code": "session_not_found", "message": "Session not found."})
    if session["completed"]:
        raise HTTPException(status_code=409, detail={"code": "session_completed", "message": "Session is already complete."})
    key = f"{user['id']}:{session_id}:{idempotency_key}" if idempotency_key else None
    if key and key in processed_turns:
        return processed_turns[key]
    turn = {"turn": len(session["turns"]) + 1, "learner_text": payload.text.strip(), "teacher_text": "Tell me more about that."}
    session["turns"].append(turn)
    if key:
        processed_turns[key] = turn
    return turn


@app.post("/v1/sessions/{session_id}/complete")
def complete_session(session_id: str, authorization: str | None = Header(default=None)):
    user = _current_user(authorization)
    session = sessions.get(session_id)
    if not session or session["user_id"] != user["id"]:
        raise HTTPException(status_code=404, detail={"code": "session_not_found", "message": "Session not found."})
    session["completed"] = True
    return {"session_id": session_id, "turn_count": len(session["turns"]), "completed": True}


@app.get("/v1/progress")
def progress(authorization: str | None = Header(default=None)):
    user = _current_user(authorization)
    completed = [sessions[sid] for sid in user["sessions"] if sessions[sid]["completed"]]
    turns = sum(len(s["turns"]) for s in completed)
    return {"completed_sessions": len(completed), "total_turns": turns, "current_streak": user["streak"]}
