# 29 — Release Readiness

## Purpose
Define objective gates for a production release.

## Functional Gates
Core onboarding, assessment, scenario selection, conversation, feedback, session summary, progress, account, privacy, and recovery flows must work for supported configurations.

## Quality Gates
Required automated tests pass; critical regressions are resolved; AI evaluation meets agreed thresholds; performance is within targets; accessibility and UX checks are complete.

## Security Gates
No known unresolved critical security findings, secrets scan clean, authentication/authorization verified, dependency risks reviewed, and production configuration checked.

## Privacy Gates
Data collection, AI processing disclosures, retention, deletion, and consent/privacy controls are implemented and reviewed.

## Operations Gates
Monitoring, alerts, backups/recovery where applicable, incident ownership, deployment/rollback procedures, and support documentation are ready.

## Rollback
Every release has a defined rollback or forward-fix strategy appropriate to database/schema changes.

## Acceptance Criteria
A release is approved only when functional, quality, security, privacy, and operational gates are satisfied or documented residual risks are explicitly accepted by the responsible owner.

**Status:** Approved foundation document.