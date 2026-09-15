# Persistence Schema V1 Foundation

The storage model is organized by domain ownership rather than UI screens.

## Core records

- `learner_profile`: identity-independent learning profile and preferences.
- `learner_memory`: approved learning signals such as repeated error categories, vocabulary targets, interests, and goals.
- `learning_session`: session metadata, scenario reference, timestamps, status, and aggregate metrics.
- `learning_event`: normalized events used by progress and adaptive learning.
- `scenario`: scenario metadata and level/difficulty information.

## Data minimization

Raw conversation text is not treated as the default long-term memory representation. Prefer normalized learning signals and aggregate session data. Retention and deletion follow the privacy policy.

## Integrity

All records require stable identifiers, timestamps, schema versions, and ownership boundaries. Critical mutations must be transactional or otherwise idempotent.

The concrete database engine is intentionally deferred until the backend technology decision is finalized.
