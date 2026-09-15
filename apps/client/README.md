# LingoMind Client

The LingoMind client is the Flutter presentation layer.

## Intended structure

```text
lib/
  core/           # cross-cutting concerns
  domain/         # learner-facing domain models and contracts
  application/    # use cases and orchestration-facing state
  infrastructure/# platform/provider adapters
  presentation/  # screens, widgets, navigation, UI state
```

## Dependency direction

`presentation → application → domain`

Infrastructure adapters implement contracts consumed by the application/domain layers. UI code must not directly depend on concrete AI, database, authentication, or network providers.

## Security baseline

- No API keys or provider secrets in the client.
- Treat remote responses and user input as untrusted.
- Keep sensitive learner data out of logs by default.
- Use secure platform storage for credentials/tokens where required.
- Add tests for security-sensitive behavior.
