# V1 Error Model

Every API error uses a stable machine-readable code and a safe human-readable message.

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "The request could not be processed.",
    "request_id": "req_..."
  }
}
```

## Rules

- Never return stack traces.
- Never return provider credentials, prompts, SQL/database details, or internal topology.
- Validation errors may identify the invalid field when safe.
- Authentication failures must not reveal whether a protected resource exists.
- Rate-limit responses may include a retry hint.
- Every request receives a correlation/request ID for safe diagnostics.
