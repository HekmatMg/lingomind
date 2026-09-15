# 18 — API Contracts

## Purpose
Define stable communication rules between clients and backend services.

## Conventions
Use versioned endpoints, JSON schemas where applicable, explicit content types, request IDs, pagination rules, and consistent timestamps/identifiers.

## Authentication
Authenticated endpoints require validated sessions/tokens. Authorization is checked server-side for every protected resource.

## Validation
Reject malformed, oversized, unsupported, or unauthorized input before domain processing. Client validation improves UX but is never the security boundary.

## Errors
Errors use stable machine-readable codes plus safe human messages. Internal stack traces, provider secrets, database details, and prompts are never returned.

## Idempotency
Mutation endpoints that may be retried use idempotency keys where duplicate processing could cause incorrect state or cost.

## Compatibility
Breaking changes require a new version or migration strategy. Contracts are tested in CI.

## Acceptance Criteria
- Schemas are explicit and versioned.
- Errors are safe and consistent.
- Authorization is server-side.
- Retries cannot silently duplicate critical operations.
- Contract changes are tested.

**Status:** Approved foundation document.