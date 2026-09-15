# Backend Security Contracts

## Authentication
The API accepts only validated authentication credentials through the selected identity provider. Tokens are never persisted in ordinary application logs.

## Authorization
Every protected resource is checked against the authenticated learner identity and resource ownership. Administrative privileges are separate from learner privileges.

## Rate limiting
Apply limits by authenticated identity and, where appropriate, network/request characteristics. Limits must protect both service availability and AI-provider spend.

## Input validation
Reject malformed, oversized, unsupported, or unauthorized requests before invoking domain services or AI providers.

## Audit events
Record security-relevant events using non-sensitive identifiers and outcomes. Do not store raw learner conversation content unless explicitly required by an approved retention policy.

## Secrets
Provider keys, signing secrets, database credentials, and other secrets are injected through protected runtime configuration. They must never be committed to Git or shipped to the Flutter client.
