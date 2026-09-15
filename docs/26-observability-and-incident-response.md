# 26 — Observability and Incident Response

## Purpose
Provide enough telemetry to detect failures, diagnose them, and recover without exposing learner data.

## Signals
Metrics for availability, latency, error rate, provider failures, queue health, resource usage, cost, and key learning-service health indicators. Logs and traces use correlation IDs.

## Privacy
Avoid logging raw learner audio, transcripts, tokens, secrets, or unnecessary personal data. Redact sensitive fields.

## Alerting
Alerts should be actionable, severity-based, and resistant to noisy repetition. Critical alerts have ownership and escalation paths.

## Incident Lifecycle
Detect → triage → contain → communicate → remediate → verify recovery → post-incident review.

## Recovery
Maintain documented rollback, provider fallback, credential rotation, data recovery, and service restoration procedures as applicable.

## Acceptance Criteria
- Critical failures are observable.
- Logs are privacy-aware.
- Incidents have owners and runbooks.
- Recovery is tested where practical.
- Post-incident learning feeds architecture improvements.

**Status:** Approved foundation document.