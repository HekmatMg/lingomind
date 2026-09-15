# 30 — V1 Scope and Acceptance Criteria

## Purpose
Freeze the V1.0 scope and provide the final acceptance framework for implementation and release.

## In Scope
- Account and learner profile foundations.
- Initial level assessment.
- Personalized home and scenario selection.
- Scenario-based AI conversation.
- AI teacher persona and supported avatar/voice interaction.
- Error detection and selective correction.
- Persian bilingual feedback for supported Persian learners.
- Vocabulary retrieval support.
- Learning Brain personalization.
- Teaching Brain and conversation orchestration.
- Learner memory and progress tracking.
- Review and next-practice recommendations.
- Privacy, security, abuse controls, observability, testing, CI/CD, and release operations.

## Out of Scope
Native-level fluency guarantees, unrestricted general-purpose assistant behavior, every world language, unlimited avatar modalities, unsupported professional advice, and features that do not strengthen the core learning loop.

## Definition of Done
A V1 capability is complete when requirements are documented, architecture boundaries are respected, implementation is tested, security/privacy implications are addressed, failure states are handled, observability exists where appropriate, and user-facing behavior matches acceptance criteria.

## Product Acceptance
A representative learner can create an account, establish a starting level and goals, receive a suitable scenario, converse with the AI teacher, receive useful contextual corrections, continue the conversation, finish a session, see meaningful progress, and receive a personalized next step.

## Security Acceptance
Protected resources enforce authorization; secrets are protected; untrusted input/output is validated; abuse controls are active; security tests pass; and no known critical release blocker remains.

## Privacy Acceptance
Only necessary learner data is collected, AI processing is disclosed, retention/deletion controls are implemented, and sensitive data is appropriately protected.

## Quality Acceptance
Critical user journeys pass automated tests; AI behavior passes defined evaluation suites; performance meets approved targets; and recovery paths are verified.

## Scope Freeze
The canonical V1.0 documentation set contains exactly 30 documents. New requirements should be evaluated against this scope before implementation; additions require an explicit project decision.

## Final Principle
V1 succeeds by delivering a reliable personalized speaking-learning loop, not by maximizing feature count.

**Status:** Approved foundation document.