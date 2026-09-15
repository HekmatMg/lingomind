# API Service

The API service is the server-side entry point for authenticated application use cases.

## Responsibilities

- Authenticate and authorize requests.
- Validate request schemas and size limits.
- Attach request IDs and enforce idempotency where required.
- Apply rate limits and abuse controls.
- Invoke domain services through explicit interfaces.
- Return stable, safe API errors.

Provider credentials, database credentials, and internal prompts never belong in the client or API responses.
