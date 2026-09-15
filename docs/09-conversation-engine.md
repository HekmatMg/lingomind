# 09 — Conversation Engine

## Purpose
Orchestrate real-time conversation state across learner input, AI analysis, feedback, and continuation.

## State
A session includes lifecycle status, scenario, objective, turn index, conversation context, teacher state, pending analysis, correction state, and completion reason. State transitions must be explicit.

## Core Loop
`READY → PROMPTING → LISTENING → PROCESSING → FEEDBACK_OR_CONTINUE → PROMPTING`.
Terminal states include `COMPLETED`, `ABANDONED`, and controlled `FAILED`.

## Responsibilities
The engine coordinates services but does not own provider-specific implementation. It enforces turn order, timeouts, cancellation, retry behavior, and safe output handling.

## Context Management
Only relevant conversation history is sent to downstream models. Long histories may be summarized under defined rules. Secrets, internal prompts, and unnecessary personal data never enter learner-facing context.

## Interruptions
Pause, exit, network loss, and audio failure must preserve recoverable state when feasible.

## Idempotency
Retryable operations require request/session identifiers so duplicate events do not create duplicate learning records or charges.

## Acceptance Criteria
- State transitions are explicit and testable.
- Timeouts and cancellations are bounded.
- Context is minimized.
- Retries are safe.
- Provider failures do not corrupt learner state.

**Status:** Approved foundation document.