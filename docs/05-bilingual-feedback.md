# 05 — Bilingual Feedback

## Purpose
Define how LingoMind gives corrections in a learner's native language while keeping the learning conversation in English.

## Default Rule
For supported learners whose native language is Persian, a correction is presented as:
1. Short natural Persian explanation.
2. Correct English sentence or phrase.
3. Immediate continuation in English.

Example: `کارت خوب بود، ولی به‌جای "goed" باید بگی "went".` → `I went to school yesterday.` → continue in English.

## When to Correct
Correct errors that materially affect meaning, recur, match the session objective, or represent high-value learning opportunities. Minor errors may be deferred.

## Explanation Rules
Persian explanations must be brief, conversational, non-technical unless technical terminology helps, and focused on the exact learner error. Avoid translating the entire conversation.

## Language Selection
The learner profile determines native/support language. If unavailable, the system falls back to configured UI language or concise English clarification. The system must never infer sensitive identity attributes from language alone.

## Correction Structure
`reason` → `correct form` → optional `one-line contrast` → English continuation.

## Multiple Errors
Prioritize one or two errors per turn unless the learner explicitly requests detailed correction. Remaining errors may be stored for later review.

## Vocabulary Gaps
If the issue is retrieval rather than incorrect grammar, provide a contextual hint before directly supplying the word when appropriate.

## Pronunciation
Where pronunciation feedback is supported, state the observed issue with calibrated confidence and provide a simple model pronunciation or repeat opportunity.

## Acceptance Criteria
- Persian corrections are concise and natural.
- Corrected English is explicit.
- Conversation resumes in English.
- Feedback does not overwhelm the learner.
- Uncertain detections are not presented as certain.
- Correction events are available to learner memory and review systems.

**Status:** Approved foundation document.