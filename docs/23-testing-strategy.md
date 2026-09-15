# 23 — Testing Strategy

## Purpose
Verify correctness, security, reliability, and learning quality across the platform.

## Test Layers
- Unit tests for domain rules and transformations.
- Integration tests for service boundaries and persistence.
- API/contract tests for schemas and authorization.
- E2E tests for critical learner journeys.
- Security tests for auth, access control, injection, abuse, and secrets.
- AI evaluations for detection, correction, teaching behavior, safety, and output validity.

## AI Evaluation
Use fixed evaluation sets, adversarial cases, multilingual cases, level-specific examples, regression suites, and human review for ambiguous quality judgments.

## Non-Functional Testing
Measure latency, reliability, resource usage, concurrency, provider failure behavior, and recovery.

## Test Data
Never use real sensitive learner data in tests unless explicitly authorized and protected. Prefer synthetic and de-identified datasets.

## CI Gates
Critical tests, formatting/linting, dependency/security checks, and contract validation must pass before protected releases.

## Acceptance Criteria
- Critical user journeys are covered.
- Security regressions are tested.
- AI quality has repeatable evaluation.
- Failures are diagnosable.
- Test suites remain maintainable.

**Status:** Approved foundation document.