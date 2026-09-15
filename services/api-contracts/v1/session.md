# V1 Session API Contract

## Start session
`POST /api/v1/sessions`

Request:
- `scenario_id`: string
- `client_request_id`: string

Response:
- `session_id`: string
- `scenario_id`: string
- `status`: `active`
- `created_at`: ISO-8601 timestamp

## Submit turn
`POST /api/v1/sessions/{session_id}/turns`

Request:
- `turn_id`: string
- `text`: string
- `idempotency_key`: string

Response:
- `turn_id`: string
- `teacher_text`: string
- `correction`: optional structured correction
- `status`: `active`

## Complete session
`POST /api/v1/sessions/{session_id}/complete`

Response:
- `session_id`: string
- `status`: `completed`
- `summary`: structured session metrics

Protected endpoints require authenticated sessions. The server validates ownership and all input. Internal errors are represented by safe machine-readable error codes.
