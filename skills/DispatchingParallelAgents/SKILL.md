---
name: DispatchingParallelAgents
description: Spin up parallel agents for concurrent work. USE WHEN user asks for parallelization OR tasks are independent OR explicit "parallel" mentioned.
---

# DispatchingParallelAgents

Launch multiple agents concurrently when tasks are independent.

## Workflow Routing

| Workflow | Trigger | File |
|----------|---------|------|
| **Dispatch** | "parallel", "concurrent", "at the same time" | Inline |

## Process

1. Validate independence: no shared files or ordering constraints.
2. Define each mini-brief: goal, files, deliverable, verification, timebox.
3. Launch only the needed agents; avoid shotgun spawning.
4. Merge results carefully: prefer non-overlapping files; otherwise, reconcile sequentially.
5. Update `plans/{slug}.md` with what was parallelized and remaining gaps.

## Examples

**Example 1: Multi-agent review**
```
User: "Review for security, performance, and architecture"
→ Invokes DispatchingParallelAgents
→ Spawns security-sentinel, performance-oracle, architecture-strategist in parallel
→ Aggregates findings
```

**Example 2: Parallel implementation**
```
User: "Implement logging, metrics, and alerting in parallel"
→ Validates no shared files
→ Dispatches 3 agents with clear deliverables
→ Merges results
```
