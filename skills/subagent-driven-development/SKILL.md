---
name: workflows-subagent-driven-development
description: Break large plans into parallelizable chunks and delegate to subagents; use only when work can safely run concurrently.
---

# Subagent-Driven Development

Trigger only when the plan has >6 tasks or explicit parallel/agent wording.

Process:
1. Partition the plan into independent workstreams with owners/tools per stream.
2. Define clear deliverables and verification per workstream; avoid shared mutable files.
3. Dispatch subagents with minimal scope and timebox; capture task IDs.
4. Collect results, reconcile conflicts, and re-run verifications.
5. Update `plans/{slug}.md` with what ran in parallel and outcomes.

If tasks share the same files or ordering matters, fall back to `executing-plans`.
