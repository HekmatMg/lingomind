# 03 — Screens

## 1. Purpose

This document defines the V1.0 screen inventory and the responsibility of each screen. Visual design details are intentionally separated from product behavior.

## 2. Screen Map

```text
Authentication
├── Welcome
├── Sign In
└── Sign Up

Onboarding
├── Profile Setup
├── Level Assessment
├── Learning Goals
└── Interests / Preferences

Core Product
├── Home
├── Scenario Selection
├── Conversation
├── Session Summary
├── Progress
└── Review

Account
├── Profile
├── Learning Preferences
├── Privacy & Data
├── Security
└── Settings
```

## 3. Welcome

**Purpose:** Explain the product value and start onboarding.

**Primary action:** Begin.

**Requirements:**

- Clear value proposition.
- Minimal text.
- No unnecessary data collection.

## 4. Authentication

### Sign In

Allows an existing learner to authenticate securely.

### Sign Up

Creates a new learner account using the supported authentication architecture.

Authentication screens must not reveal whether a specific account exists when doing so could create account-enumeration risk.

## 5. Profile Setup

Collects minimum information needed for initial personalization.

Possible fields:

- Native language.
- Current English level.
- Learning goal.
- Optional learner preferences.

## 6. Level Assessment

Provides an initial estimate of English proficiency.

The UI should explain that the estimate can change as the learner demonstrates actual ability.

## 7. Learning Goals

The learner selects the main purpose of learning, for example:

- Speaking.
- Travel.
- Work.
- Study.
- Everyday communication.
- Exam preparation.

The available goals should remain configurable rather than hard-coded into the entire application.

## 8. Interests / Preferences

Allows the learner to select topics that can influence scenario generation and recommendations.

## 9. Home

The primary dashboard.

Should surface:

- Recommended next practice.
- Current progress.
- Recent learning focus.
- Continue-session action where applicable.

The home screen should not become a statistics dashboard overloaded with metrics.

## 10. Scenario Selection

The learner can accept an AI recommendation or choose from available scenarios.

Each scenario should communicate:

- Context.
- Learning objective.
- Approximate difficulty.
- Estimated duration.

## 11. Conversation

The primary learning screen.

Core areas:

- AI teacher/avatar.
- Conversation context.
- Learner input controls.
- Feedback display.
- Session progress indicator.
- Exit / pause controls.

The interface should prioritize the conversation itself.

## 12. Session Summary

Shows the most important outcomes from the completed session.

Possible sections:

- Key corrections.
- Vocabulary.
- Pronunciation / fluency observations.
- Strengths.
- Recommended review.
- Next practice.

## 13. Progress

Shows meaningful progress over time rather than raw system telemetry.

Possible dimensions:

- Speaking confidence.
- Grammar accuracy.
- Active vocabulary.
- Pronunciation.
- Fluency.
- Scenario performance.

Metrics must be backed by clearly defined measurement logic before implementation.

## 14. Review

Provides targeted practice for recurring weaknesses and recently learned material.

Review content should be generated or selected based on learner memory and learning rules rather than only chronological history.

## 15. Privacy & Data

The learner can understand and manage relevant data practices.

This screen should cover, as applicable:

- What data is stored.
- Why it is stored.
- Retention controls.
- Data deletion/export options.
- AI processing disclosures.

## 16. Security

Provides security-related account controls appropriate to the authentication system, such as:

- Active sessions.
- Password/security credentials where applicable.
- Sign-out from other sessions.
- Security notifications.

## 17. Global UX Rules

1. Primary actions must be obvious.
2. Error messages must be actionable.
3. Sensitive information must not be unnecessarily displayed.
4. Loading states must communicate progress or waiting clearly.
5. Accessibility must be considered from the first implementation.
6. Screens must remain usable on supported screen sizes.
7. UI state must survive recoverable interruptions where practical.

## 18. Current Status

**Approved foundation document.**

Detailed visual design, components, accessibility requirements, and responsive behavior will be defined during the UI/UX implementation phase.
