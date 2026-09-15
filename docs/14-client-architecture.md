# 14 — Client Architecture

## Purpose
Define the Flutter application's structural boundaries and responsibilities.

## Layers
- Presentation: screens, widgets, accessibility, view state.
- Application: user actions, session coordination, navigation decisions.
- Domain: learner, scenario, conversation, progress models and business rules.
- Data: API clients, local persistence, serialization, caching.

## Principles
UI does not own business rules or secrets. Network models are mapped to domain models. State transitions are explicit. Provider SDKs are isolated behind adapters.

## Local Storage
Store only necessary non-sensitive or appropriately protected data. Tokens and secrets use platform-secure storage where applicable. Cached learner content follows retention rules.

## Offline/Degraded Mode
The client should distinguish unavailable network services from invalid user input and show actionable recovery. It must never silently assume a server write succeeded.

## Acceptance Criteria
- Clear separation of concerns.
- Testable domain/application logic.
- Secure credential handling.
- Explicit loading/error/empty states.
- No business-critical state hidden solely in UI widgets.

**Status:** Approved foundation document.