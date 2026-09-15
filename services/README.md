# Services

This directory contains backend services and service-level adapters.

## Boundary rules

- Services own server-side business workflows and integrations.
- Client applications must not contain provider credentials.
- External AI, speech, storage, and authentication providers are accessed through explicit interfaces.
- Sensitive learner data must follow the privacy, security, retention, and access rules defined in the V1 documentation.
