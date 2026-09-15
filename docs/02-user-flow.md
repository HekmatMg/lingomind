# 02 — User Flow

## 1. Purpose

This document defines the canonical V1.0 learner journey from first launch through recurring personalized learning.

## 2. Primary Flow

```text
Launch
  ↓
Welcome / Account
  ↓
Learner Profile Setup
  ↓
English Level Assessment
  ↓
Learning Goals
  ↓
Personalized Home
  ↓
Choose / Receive Scenario
  ↓
AI Conversation
  ↓
Detection & Feedback
  ↓
Conversation Continues
  ↓
Session Summary
  ↓
Progress & Learning Memory Update
  ↓
Next Recommended Practice
```

## 3. First-Time User Flow

### Step 1 — Welcome

The learner understands what LingoMind does and starts onboarding.

### Step 2 — Account

The learner creates or signs into an account using an authentication method defined by the authentication architecture.

### Step 3 — Profile

The system collects only information required for personalization, such as:

- Native language.
- English level, if known.
- Learning goal.
- Preferred topics or interests.
- Practice frequency preference.

### Step 4 — Level Assessment

If the learner does not have a reliable level, LingoMind performs an assessment appropriate to the supported V1.0 capabilities.

The result is treated as an initial estimate rather than an immutable label.

### Step 5 — Personalized Home

The learner sees the recommended next activity and can start practice quickly.

## 4. Conversation Flow

```text
Scenario selected
  ↓
Teacher introduces context
  ↓
Teacher asks a level-appropriate question
  ↓
Learner responds
  ↓
System analyzes response
  ├── No meaningful error → Continue
  └── Error detected → Give concise feedback → Continue
  ↓
Repeat until session objective is reached
```

The conversation engine should avoid turning every response into a correction exercise. Correction frequency and depth should depend on learner needs and session context.

## 5. Feedback Flow

For a Persian-speaking learner, a correction can follow this pattern:

```text
Learner sentence
      ↓
Error detection
      ↓
Short Persian explanation
      ↓
Correct English sentence
      ↓
Conversation continues in English
```

Example:

> کارت خوب بود، ولی به‌جای **goed** باید بگی **went**.
>
> **I went to the park yesterday.**

Other supported native languages will use the same conceptual structure with localized wording.

## 6. Session Completion

At the end of a session, the learner receives a concise summary containing relevant information such as:

- What was practiced.
- Important corrections.
- Vocabulary worth reviewing.
- Pronunciation or fluency observations when available.
- Progress indicators.
- Recommended next practice.

The summary should prioritize actionable information rather than overwhelming the learner with raw diagnostics.

## 7. Learning Memory Update

After a session, relevant learning signals are passed to the learner model / Learning Brain.

Potential signals include:

- New errors.
- Repeated errors.
- Corrected errors.
- Vocabulary retrieval difficulty.
- Response latency.
- Topic engagement.
- Demonstrated mastery.
- Session completion behavior.

Only information justified by the data model and privacy policy should be retained.

## 8. Returning User Flow

```text
Login / Session restore
  ↓
Personalized Home
  ↓
Recommended Practice
  ↓
Conversation
  ↓
Feedback
  ↓
Progress Update
  ↓
Next Recommendation
```

A returning learner should not need to repeat onboarding information unnecessarily.

## 9. Failure / Recovery States

The UX must define recovery paths for:

- Network failure.
- Microphone permission denial.
- Audio input failure.
- AI service timeout.
- Authentication expiration.
- Session interruption.
- Unsafe or unsupported user input.
- Temporary service unavailability.

Errors should be understandable to the learner and should never expose internal secrets, stack traces, infrastructure details, or sensitive diagnostic data.

## 10. V1.0 Flow Rules

1. The learner should reach practice with minimal friction.
2. Every major learning session should produce useful learning signals.
3. Feedback should support conversation rather than unnecessarily stop it.
4. The learner should always understand what to do next.
5. Security and privacy controls must remain invisible where possible without reducing transparency.
6. Recovery paths must be defined before implementation of the corresponding feature.

## 11. Current Status

**Approved foundation document.**

Detailed screen specifications, teacher behavior, bilingual feedback, architecture, and learning logic are defined in subsequent documents.
