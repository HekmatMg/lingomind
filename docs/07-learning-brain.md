# 07 — Learning Brain

## Purpose
Define the adaptive learner model that converts learning signals into personalized decisions.

## Learner Model
The model tracks skill estimates across grammar, vocabulary, retrieval, pronunciation, fluency, listening-related performance where measurable, scenario familiarity, and confidence. Each estimate includes evidence, recency, and confidence rather than a single permanent score.

## Inputs
Signals may include error type/frequency, correction acceptance, retrieval latency, successful reuse, pronunciation observations, response length, task completion, scenario performance, goals, interests, and explicit learner preferences.

## Adaptation Decisions
The Learning Brain can influence scenario choice, target vocabulary, difficulty, prompt style, correction priority, review timing, and recommended session length.

## Forgetting and Recency
Recent performance receives weight, but repeated historical patterns remain relevant. Old evidence decays rather than disappearing immediately.

## Mastery
Mastery requires repeated successful performance across suitable contexts. One correct answer must not erase a persistent weakness.

## Retrieval Practice
Weak-but-known vocabulary should be surfaced through contextual prompts and spaced reuse. The system should distinguish unknown words from words the learner knows but cannot retrieve quickly.

## Personalization Constraints
Adaptation must not create an opaque or punitive experience. Learners should be able to understand meaningful recommendations and adjust goals/preferences.

## Privacy
Only necessary learning signals are retained. Sensitive content is minimized, access-controlled, and governed by the privacy architecture.

## Acceptance Criteria
- Learner state is evidence-based and confidence-aware.
- Adaptation uses multiple signals.
- Retrieval difficulty is distinct from knowledge absence where possible.
- Recommendations are explainable at a useful level.
- Historical learning affects future sessions without becoming immutable.

**Status:** Approved foundation document.