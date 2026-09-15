# 10 — Error Detection and Correction

## Purpose
Define a structured taxonomy and decision process for identifying useful language errors without overwhelming learners.

## Error Taxonomy
- Grammar and morphology
- Vocabulary choice
- Word retrieval
- Word order
- Meaning/usage
- Pronunciation
- Fluency/disfluency
- Register or naturalness

## Detection
Analysis may use speech recognition, language models, deterministic rules, or provider signals. Every detection should carry confidence and evidence where feasible.

## Severity
- **Critical:** meaning is materially wrong or unsafe to misunderstand.
- **High:** recurring or target-skill error.
- **Medium:** useful improvement with limited impact.
- **Low:** stylistic or minor naturalness issue.

## Correction Policy
Prioritize critical/high-value errors. Do not produce a correction when confidence is insufficient. Avoid duplicate corrections for the same pattern within a short context.

## Output
A correction event should identify observed form, corrected form, category, severity, confidence, explanation, and whether it should enter learner memory/review.

## Evaluation
Detection quality should be evaluated separately for precision, recall, false positives, correction usefulness, and learner interruption cost.

## Acceptance Criteria
- Taxonomy is consistent.
- Confidence is represented.
- Correction decisions are explainable.
- False positives are actively controlled.
- Events are reusable by memory, assessment, and review systems.

**Status:** Approved foundation document.