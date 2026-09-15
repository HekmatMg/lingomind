# 19 — Threat Model

## Purpose
Identify major assets, actors, attack surfaces, and mitigations before implementation.

## Assets
Accounts, authentication tokens, learner data, conversation content, learning history, provider credentials, application configuration, and operational logs.

## Threat Actors
Unauthenticated attackers, compromised accounts, malicious users, automated abuse, compromised dependencies, and accidental internal misuse.

## Attack Surfaces
Client applications, APIs, authentication flows, file/audio inputs, AI provider integrations, admin tooling, CI/CD, dependencies, and logs.

## Key Threats
Account takeover, authorization bypass, data leakage, prompt injection, malicious uploads, abuse/cost exhaustion, secret exposure, dependency compromise, injection attacks, and privacy violations.

## Mitigations
Strong authentication/session controls, object-level authorization, input/output validation, least privilege, rate limits, secure secret storage, dependency scanning, safe file handling, provider isolation, logging/monitoring, and incident response.

## Trust Boundaries
Client-to-server, server-to-provider, service-to-database, and developer-to-production are explicit trust boundaries. Data crossing each boundary is validated and minimized.

## Acceptance Criteria
- Threats are mapped to controls.
- High-impact attack paths have mitigations before release.
- Residual risk is documented.
- Threat modeling is revisited after major architecture changes.

**Status:** Approved foundation document.