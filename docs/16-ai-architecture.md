# 16 — AI Architecture

## Purpose
Define replaceable AI capabilities and their boundaries.

## Capabilities
- Language understanding/generation
- Speech-to-text
- Text-to-speech
- Pronunciation analysis where supported
- Avatar/lip-sync orchestration
- Teaching and learning orchestration

## Provider Abstraction
Provider-specific APIs are hidden behind adapters. Domain code uses normalized internal contracts so providers can be replaced or combined.

## Prompting
Prompts are versioned application assets. System instructions and secrets are never exposed to learners. Prompt inputs are minimized and validated.

## AI Output Handling
Model output is untrusted. Validate schema, enforce length/type constraints, apply safety checks, and reject malformed output before learner display or persistence.

## Evaluation
Track task-specific quality, hallucination/error rates, latency, cost, safety failures, and learner usefulness. Evaluation sets should include representative language levels and error patterns.

## Acceptance Criteria
- Providers are replaceable.
- AI outputs are validated.
- Secrets remain server-side.
- Prompt versions are traceable.
- Quality, safety, latency, and cost are measurable.

**Status:** Approved foundation document.