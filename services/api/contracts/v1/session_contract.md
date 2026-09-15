# V1 Session Contract

## Start session

`POST /v1/sessions`

Request:
- `scenario_id`: string, required

Response:
- `session_id`: opaque identifier
- `scenario_id`: string
- `status`: `active`

## Submit learner turn

`POST /v1/sessions/{session_id}/turns`

Request:
- `text`: non-empty string within configured size limit
- `idempotency_key`: required for retry-safe mutation

Response:
- `teacher_message`: normalized teacher response
- `corrections`: zero or more validated correction objects
- `turn_number`: integer

## Finish session

`POST /v1/sessions/{session_id}/complete`

Response:
- `status`: `completed`
- `result`: session summary metrics

## Error envelope

```json
{
  "code": "stable_machine_code",
  "message": "Safe human-readable message",
  "request_id": "opaque-request-id"
}
```

Internal stack traces, provider errors, prompts, credentials, and database details are never returned.
