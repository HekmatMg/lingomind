# AI Gateway

The AI gateway isolates external AI providers from LingoMind domain logic.

## Capabilities

- Text conversation generation
- Error analysis and correction
- Speech-to-text
- Text-to-speech
- Pronunciation analysis
- Avatar/lip-sync orchestration

## Rules

- Provider credentials are server-side only.
- Every provider response is untrusted and must be schema-validated.
- Timeouts, quotas, retries, and provider failures are normalized.
- Domain services consume provider-neutral contracts.
- Prompt versions are traceable without exposing internal prompts to learners.
