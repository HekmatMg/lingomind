# 28 — Performance and Scalability

## Purpose
Define performance goals and scaling principles for responsive learning sessions.

## Key Metrics
Measure time to interactive, API latency, speech round-trip latency, model latency, avatar response latency, error rate, concurrency, database performance, and infrastructure cost.

## Targets
Initial targets should be set from real measurements. User-facing conversation should prioritize predictable latency and graceful degradation over theoretical peak throughput.

## Optimization
Use bounded context, caching for safe stable content, connection reuse, asynchronous processing for non-critical work, and efficient media handling.

## Scaling
Scale stateless application components horizontally. Identify database and provider limits before they become bottlenecks. Use queues for bursty background work.

## Cost Controls
Provider quotas, request budgets, caching, model selection, and abuse limits prevent uncontrolled AI spend.

## Acceptance Criteria
- Performance baselines are measured.
- Critical latency has explicit targets.
- Scaling bottlenecks are identified.
- AI cost has controls.
- Degraded modes preserve core safety and state integrity.

**Status:** Approved foundation document.