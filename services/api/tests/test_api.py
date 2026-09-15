from fastapi.testclient import TestClient

from app.main import app, revoked_tokens, users

client = TestClient(app)


def test_health():
    response = client.get('/health')
    assert response.status_code == 200
    assert response.json()['status'] == 'ok'


def test_register_login_and_session_flow():
    email = 'test-' + __import__('uuid').uuid4().hex + '@example.com'
    register = client.post('/v1/auth/register', json={'email': email, 'password': 'correct-horse-battery', 'name': 'Test Learner'})
    assert register.status_code == 200

    login = client.post('/v1/auth/login', json={'email': email, 'password': 'correct-horse-battery'})
    assert login.status_code == 200
    token = login.json()['access_token']
    headers = {'Authorization': f'Bearer {token}'}

    me = client.get('/v1/me', headers=headers)
    assert me.status_code == 200
    assert me.json()['email'] == email

    created = client.post('/v1/sessions', headers=headers, json={'scenario_id': 'coffee-shop'})
    assert created.status_code == 200
    session_id = created.json()['session_id']

    turn = client.post(f'/v1/sessions/{session_id}/turns', headers={**headers, 'Idempotency-Key': 'turn-1'}, json={'text': 'I want a coffee.'})
    assert turn.status_code == 200
    duplicate = client.post(f'/v1/sessions/{session_id}/turns', headers={**headers, 'Idempotency-Key': 'turn-1'}, json={'text': 'I want a coffee.'})
    assert duplicate.status_code == 200
    assert duplicate.json()['turn'] == 1

    completed = client.post(f'/v1/sessions/{session_id}/complete', headers=headers)
    assert completed.status_code == 200
    assert completed.json()['completed'] is True


def test_logout_revokes_token():
    email = 'logout-' + __import__('uuid').uuid4().hex + '@example.com'
    client.post('/v1/auth/register', json={'email': email, 'password': 'correct-horse-battery', 'name': 'Logout Learner'})
    login = client.post('/v1/auth/login', json={'email': email, 'password': 'correct-horse-battery'})
    token = login.json()['access_token']
    headers = {'Authorization': f'Bearer {token}'}

    logout = client.post('/v1/auth/logout', headers=headers)
    assert logout.status_code == 200
    assert client.get('/v1/me', headers=headers).status_code == 401


def test_invalid_email_is_rejected():
    response = client.post('/v1/auth/register', json={'email': 'not-an-email', 'password': 'correct-horse-battery', 'name': 'Test'})
    assert response.status_code == 422


def test_short_password_is_rejected():
    response = client.post('/v1/auth/register', json={'email': 'short@example.com', 'password': 'short', 'name': 'Test'})
    assert response.status_code == 422


def test_unauthenticated_access_is_rejected():
    response = client.get('/v1/progress')
    assert response.status_code == 401
