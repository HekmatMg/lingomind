# V1 Learner API Contract

## Get learner state
`GET /api/v1/learner`

Returns the authenticated learner's non-sensitive profile and learning state.

## Get progress
`GET /api/v1/learner/progress`

Returns aggregated progress metrics and recent learning signals.

## Get recommendations
`GET /api/v1/learner/recommendations`

Returns scenarios selected by the Learning service using the learner's level, goals, interests, progress, and approved memory signals.

## Update learning preferences
`PATCH /api/v1/learner/preferences`

Only explicitly supported preference fields may be changed. Server-side authorization and validation are mandatory.

No endpoint returns authentication secrets, provider credentials, hidden prompts, or unnecessary raw conversation history.
