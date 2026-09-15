# 01 — Project Vision

## 1. Purpose

LingoMind is an AI-powered English learning platform designed to help learners develop practical English communication skills through personalized, continuous, scenario-based conversation.

The product is intended to move beyond static lessons and isolated exercises by creating an adaptive learning environment in which the AI teacher remembers relevant learner history, detects recurring weaknesses, adjusts difficulty, and guides the learner toward measurable progress.

## 2. Problem

Traditional English-learning products often separate vocabulary, grammar, pronunciation, listening, and speaking into disconnected activities. Learners may understand a rule during a lesson but fail to retrieve the right word or sentence while speaking.

LingoMind addresses this gap by making conversation the central learning experience and using learner data to personalize what happens next.

## 3. Product Vision

LingoMind should feel like having a patient, intelligent English teacher who knows the learner's history and continuously adapts the lesson to the learner.

The experience should be:

- Conversational rather than form-driven.
- Adaptive rather than identical for every learner.
- Corrective without interrupting the natural flow excessively.
- Progressive, with difficulty increasing as competence improves.
- Contextual, using realistic situations and scenarios.
- Persistent, using long-term learning memory where appropriate.
- Privacy-conscious and secure by design.

## 4. Target Learner Experience

A learner should be able to enter a conversation, understand what the AI teacher is asking, respond naturally, receive useful correction when needed, and continue the conversation without feeling that every sentence has become a test.

The system should identify patterns such as:

- Repeated grammar errors.
- Missing or weak vocabulary.
- Difficulty retrieving known words during speech.
- Pronunciation problems.
- Slow or hesitant responses.
- Topics that increase engagement.
- Areas in which the learner is consistently improving.

These signals should influence future activities through the Learning Brain.

## 5. Core Product Principles

### 5.1 Conversation first

Speaking and meaningful communication are primary product experiences. Supporting exercises should strengthen conversational ability rather than exist independently from it.

### 5.2 Personalization

The system should adapt to the learner's level, goals, mistakes, interests, pace, and demonstrated progress.

### 5.3 Useful correction

Corrections should be concise, understandable, and appropriately timed. The objective is improvement, not interruption for its own sake.

### 5.4 Long-term learning memory

Relevant learning history should persist so the system can recognize recurring problems and avoid repeatedly teaching material the learner has already mastered.

### 5.5 Native-language support

When appropriate, explanations can use the learner's native language. For Persian-speaking learners, the correction flow should be natural and concise in Persian before returning to English conversation.

Example:

> کارت خوب بود، ولی به‌جای **goed** باید بگی **went**.
>
> **I went to the store yesterday.**

The conversation then continues in English.

### 5.6 Security and privacy

Learner information, authentication data, conversation data, and AI-related infrastructure must be protected using defense-in-depth security practices and data minimization.

## 6. Product Goals

### Primary goals

1. Improve real-world English speaking ability.
2. Increase vocabulary retrieval and active vocabulary.
3. Improve grammar accuracy through contextual correction.
4. Improve pronunciation and spoken fluency.
5. Provide measurable, long-term learner progress.
6. Deliver personalized practice rather than a fixed curriculum for everyone.

### Secondary goals

1. Make English practice engaging enough to sustain regular use.
2. Reduce learner frustration caused by repetitive or irrelevant exercises.
3. Create a technical foundation that can scale from an MVP to a production platform.
4. Establish a secure architecture from the beginning rather than retrofitting security later.

## 7. Non-Goals for V1.0

The following are explicitly outside the initial V1.0 scope unless later approved:

- Guaranteeing native-level fluency.
- Replacing human teachers in every educational context.
- Supporting every world language from the first release.
- Building an unrestricted general-purpose AI assistant.
- Implementing every possible learning modality before validating the core conversation loop.

## 8. Success Criteria

V1.0 should be considered successful when the system can reliably provide a secure, personalized learning loop in which a learner can:

1. Start a level-appropriate conversation.
2. Respond using voice or the supported interaction mode.
3. Receive contextually relevant corrections.
4. Continue the conversation naturally.
5. Have meaningful learning signals recorded.
6. Receive increasingly personalized future practice.
7. View understandable evidence of progress.

Technical implementation details and measurable product metrics will be defined in the relevant V1.0 documents.

## 9. Architectural Consequence

The product vision requires clear separation between:

- Client experience.
- Conversation orchestration.
- AI services.
- Learning Brain and learner modeling.
- Persistent learner data.
- Authentication and authorization.
- Observability and security controls.

These boundaries will be defined in the architecture documentation before production implementation.

## 10. Decision Log

| Decision | Status | Reason |
|---|---|---|
| Conversation is the primary learning loop | Accepted | Directly targets practical communication ability |
| Adaptive personalization is a core capability | Accepted | Learners have different weaknesses and goals |
| Long-term learner memory is part of the product vision | Accepted | Enables continuity and personalized progression |
| Security is a first-class requirement | Accepted | Learner and conversation data require protection |
| Documentation precedes implementation | Accepted | Reduces architectural drift and rework |
| V1.0 documentation set contains exactly 30 canonical documents | Accepted | Keeps scope controlled and auditable |

## 11. Current Status

**Approved foundation document.**

This document defines the product direction. Subsequent documents may refine implementation details but should not silently contradict these core principles.
