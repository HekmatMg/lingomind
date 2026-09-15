# 15 — Backend Architecture

## Purpose
Define backend service boundaries and operational responsibilities.

## Services
V1 may logically separate authentication, API, conversation orchestration, learner/memory, scenarios/content, progress, and provider integrations. Physical deployment may combine services until scale requires separation.

## API Layer
Validates authentication, authorization, input schema, rate limits, request IDs, and response contracts before invoking domain services.

## Provider Adapters
External AI, speech, and avatar providers are accessed through server-side adapters with timeouts, quotas, error normalization, and provider-specific secrets.

## Persistence
Database ownership follows domain boundaries. Transactions are used for consistency-critical updates. Background processing is used for non-blocking aggregation where safe.

## Security
Least privilege, secret management, validation, rate limiting, audit-relevant events, encrypted transport, and controlled administrative access are mandatory.

## Acceptance Criteria
- Responsibilities are explicit.
- External providers cannot bypass backend controls.
- Service failures are bounded.
- Data access is authorized by ownership.
- Architecture can scale without premature microservice complexity.

**Status:** Approved foundation document.