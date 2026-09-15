# Backend Service Boundaries

The backend is organized around explicit responsibilities rather than provider-specific implementations.

## Initial boundaries

- **API/Application service** — authenticated request handling and use-case orchestration.
- **Conversation service** — conversation/session state and turn orchestration.
- **Learning service** — learner profile, learning signals, progress, and recommendations.
- **AI gateway** — provider-neutral interfaces for language, speech, and related AI capabilities.
- **Persistence layer** — repositories for learner and session data.
- **Security layer** — authentication, authorization, rate limiting, validation, and audit controls.

Provider credentials remain server-side. Domain logic must not depend directly on a specific AI vendor.
