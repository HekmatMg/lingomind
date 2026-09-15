# 24 — Code Quality and Standards

## Purpose
Define maintainable engineering standards for LingoMind.

## General Rules
Prefer readable, small, cohesive modules; explicit dependencies; meaningful names; predictable error handling; and minimal duplication.

## Flutter/Dart
Follow official Dart/Flutter conventions, static analysis, formatting, immutable models where practical, and separation of UI from domain logic.

## Backend
Use strict typing where supported, schema validation, structured errors, dependency isolation, and explicit authorization checks.

## Security
No secrets in source. Validate untrusted input. Avoid unsafe dynamic execution. Review security-sensitive changes explicitly.

## Git
Use small focused commits and descriptive conventional-style messages. Do not commit generated secrets, local credentials, or sensitive learner data.

## Review
Changes should be reviewed for correctness, architecture, security, tests, performance impact, and maintainability.

## Acceptance Criteria
- Automated formatting/linting is configured.
- Quality rules are enforceable in CI.
- Security-sensitive code receives focused review.
- Technical debt is documented rather than hidden.

**Status:** Approved foundation document.