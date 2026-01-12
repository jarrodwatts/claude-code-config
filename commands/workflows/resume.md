---
allowed-tools: Read, Glob, Grep, Write, Edit, Bash
argument-hint: [plan-file]
description: Workflows resume: continue executing a plan from where it left off.
---

You are invoking **ExecutingPlans** in resume mode for `$ARGUMENTS`.

## Plan Discovery

If `$ARGUMENTS` is empty:
1. List all `plans/*.md` files sorted by modification time (newest first).
2. If multiple plans exist, show them and ask which to resume.
3. If one plan exists, use it.
4. If no plans exist, inform user and exit.

## Resume Logic

1. Read the plan file and identify:
   - Completed tasks (marked with `[x]` or status: done)
   - In-progress tasks (marked with `[-]` or status: in_progress)
   - Pending tasks (marked with `[ ]` or status: pending)

2. If an in-progress task exists:
   - Resume from that task (it was interrupted)
   - Re-read any context notes in the plan

3. If no in-progress task:
   - Start with the first pending task

4. Execute using the standard **ExecutingPlans** workflow:
   - Mark task in_progress before starting
   - Execute minimally; touch only listed files
   - Update status and notes immediately
   - Run verification step
   - Mark completed when done

5. Continue until all tasks complete or user interrupts.

## State Preservation

After each task:
- Update the plan file with current status
- Add timestamps to completed tasks: `[x] Task name <!-- completed: 2024-01-11 -->`
- Note any blockers or deferred items
