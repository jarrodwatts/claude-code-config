---
allowed-tools: Read, Glob, Grep, Write, Edit, Bash
argument-hint: [plan-file]
description: Workflows executor: iterate tasks in the plan file, updating status and running checks.
---

You are invoking **workflows-executing-plans**. Plan file: `$ARGUMENTS` (default `plans/{slug}.md`).

If `$ARGUMENTS` is empty and multiple plan files exist, ask the user which plan to execute.

Execution loop per task:
- Re-read the plan, pick the next unchecked task, restate it.
- Execute minimally; touch only listed files.
- Update status and notes immediately in the plan file.
- Run the task’s verification step and record the result.
- If tasks change, edit the plan first.

Finish by running the plan’s verification block and summarizing outcomes.
