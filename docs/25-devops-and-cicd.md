# 25 — DevOps and CI/CD

## Purpose
Define repeatable build, test, security, and release automation.

## Environments
Separate local/development, staging, and production configuration. Production credentials are never reused in development.

## CI Pipeline
Checkout → dependency restore → format/lint → unit tests → integration/contract tests → security scans → build → artifact validation.

## CD
Deploy only validated artifacts. Use controlled environments, approvals where appropriate, migration safety, health checks, and rollback capability.

## Configuration
Configuration is externalized and validated at startup. Secrets use secure secret storage.

## Supply Chain
Pin or constrain important dependencies, scan for vulnerabilities, review lockfile changes, and protect build credentials.

## Acceptance Criteria
- Builds are reproducible enough for release needs.
- CI blocks critical failures.
- Production deployment is controlled.
- Rollback is documented.
- Secrets never enter repository history or artifacts.

**Status:** Approved foundation document.