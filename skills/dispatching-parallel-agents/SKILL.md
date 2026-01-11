---
name: workflows-dispatching-parallel-agents
description: Spin up parallel agents only when the user asks for parallelization or tasks are independent.
---

# Dispatching Parallel Agents

Use when the user explicitly wants concurrent work or tasks are cleanly separable.

Steps:
1. Validate independence: no shared files or ordering constraints.
2. Define each mini-brief: goal, files, deliverable, verification, timebox.
3. Launch only the needed agents; avoid shotgun spawning.
4. Merge results carefully: prefer non-overlapping files; otherwise, reconcile sequentially.
5. Update `plans/{slug}.md` with what was parallelized and remaining gaps.
