# 13 — System Architecture

## Purpose
Define high-level boundaries for a secure, modular LingoMind platform.

## Logical Components
- Flutter client
- Authentication and account service
- API gateway/backend entry point
- Conversation orchestration
- Teaching Brain and Learning Brain
- AI provider adapters
- Learner data and memory storage
- Progress/assessment service
- Scenario/content service
- Observability and security controls

## Boundary Principles
Clients are untrusted. Provider credentials remain server-side. AI providers are replaceable behind adapters. Learning state has explicit ownership. Security and privacy controls apply across boundaries.

## Data Flow
Client input → authenticated API → conversation orchestration → relevant learner/scenario context → AI services → validated response → client; learning events are persisted separately under access controls.

## Reliability
External providers are failure domains. Timeouts, retries, circuit-breaking where appropriate, graceful degradation, and idempotency are required.

## Acceptance Criteria
- Boundaries are explicit.
- Secrets never reach clients.
- Provider coupling is isolated.
- Learner data ownership is clear.
- Failure domains and recovery paths are defined.

**Status:** Approved foundation document.