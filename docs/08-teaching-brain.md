# 08 — Teaching Brain

## Purpose
Define how LingoMind converts learner state and scenario goals into teaching decisions during a session.

## Responsibilities
The Teaching Brain selects prompt difficulty, support level, correction timing, question type, target vocabulary, turn length, and session pacing.

## Decision Inputs
Scenario objective, learner level, Learning Brain state, recent conversation, recent errors, current response quality, confidence signals, and session time constraints.

## Teaching Modes
- **Explore:** introduce or elicit new language.
- **Practice:** repeat a target skill with support.
- **Retrieve:** prompt weak vocabulary without immediate answers.
- **Repair:** address a recurring error.
- **Challenge:** reduce scaffolding and increase complexity.
- **Review:** consolidate previously learned material.

## Turn Strategy
Prefer one clear communicative goal per teacher turn. Ask questions that require meaningful learner output rather than unnecessary testing.

## Scaffolding
Start with contextual support and increase assistance only when needed. Reduce support after successful attempts.

## Correction Timing
Immediate correction is preferred for meaning-critical or target errors; delayed correction is preferred when interruption would damage fluency or when several minor errors compete.

## Adaptation
If the learner struggles, simplify or scaffold. If the learner performs comfortably, increase challenge. Avoid sudden difficulty jumps.

## Acceptance Criteria
- Decisions are grounded in learner and scenario state.
- Teaching modes are explicit.
- Scaffolding can increase and decrease.
- Correction timing protects both accuracy and fluency.
- Decisions are deterministic enough to test and observe.

**Status:** Approved foundation document.