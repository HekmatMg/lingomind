# Contributing to LingoMind

## Development principles

- Read the relevant documentation before changing implementation.
- Keep changes small, focused, and reviewable.
- Do not commit secrets or sensitive learner data.
- Add or update tests for behavioral changes.
- Document architectural or security decisions before implementation when they affect system boundaries.
- Prefer clear, maintainable code over premature optimization.

## Change workflow

1. Identify the requirement or issue.
2. Check the relevant V1.0 documentation.
3. Update documentation if the intended behavior or architecture changes.
4. Implement the smallest coherent change.
5. Run applicable tests and security checks.
6. Review the diff for accidental secrets, unrelated changes, and regressions.
7. Commit with a clear conventional-style message.

## Commit style

Use concise messages such as:

- `docs: define learner flow`
- `feat: add conversation session model`
- `fix: handle expired session`
- `test: add correction engine coverage`
- `security: tighten API validation`

## Security

Security-sensitive changes must follow `SECURITY.md` and must not expose secrets or private learner information.
