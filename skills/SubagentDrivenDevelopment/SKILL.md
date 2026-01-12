---
name: SubagentDrivenDevelopment
description: Break large plans into parallelizable chunks for subagents. USE WHEN plan has >6 tasks OR explicit parallel wording OR work can run concurrently.
---

# SubagentDrivenDevelopment

Partition work into independent streams for parallel execution.

## Workflow Routing

| Workflow | Trigger | File |
|----------|---------|------|
| **Partition** | "parallelize", ">6 tasks", "concurrent work" | Inline |

## Process

1. Partition the plan into independent workstreams with owners/tools per stream.
2. Define clear deliverables and verification per workstream; avoid shared mutable files.
3. Dispatch subagents with minimal scope and timebox; capture task IDs.
4. Collect results, reconcile conflicts, and re-run verifications.
5. Update `plans/{slug}.md` with what ran in parallel and outcomes.

If tasks share the same files or ordering matters, fall back to `ExecutingPlans`.

## Examples

**Example 1: Large feature**
```
User: "Implement the dashboard with 8 components"
→ Invokes SubagentDrivenDevelopment
→ Partitions into independent component workstreams
→ Dispatches agents in parallel
```

**Example 2: Multi-module work**
```
User: "Add logging to all services"
→ Validates no shared files
→ Assigns one agent per service
→ Merges results
```
