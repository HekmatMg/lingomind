# 17 — Data Architecture

## Purpose
Define ownership, storage, lifecycle, and protection of LingoMind data.

## Core Domains
Identity/account, learner profile, learning state, scenarios/content, conversation/session metadata, learning events, progress, and consent/privacy records.

## Ownership
Each record has a clear owning domain and access policy. Cross-domain reads use defined interfaces rather than unrestricted database access.

## Classification
Data is classified by sensitivity and necessity. Authentication secrets and sensitive learner content receive stronger controls than public scenario metadata.

## Lifecycle
Collect minimum necessary data → validate → use for stated purpose → retain only as required → delete/anonymize according to policy.

## Integrity
Use stable identifiers, timestamps, schema versions, constraints, and transactional updates where required. Event records should support auditability without storing unnecessary raw content.

## Acceptance Criteria
- Data ownership is explicit.
- Sensitive data is minimized and protected.
- Retention/deletion is enforceable.
- Schemas are versioned.
- Cross-domain access is controlled.

**Status:** Approved foundation document.