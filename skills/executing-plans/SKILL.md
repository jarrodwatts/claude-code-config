---
name: workflows-executing-plans
description: Default executor for written plans; iterate tasks, keep plan in sync, and run checks as you go.
---

# Executing Plans

Use when a plan exists or tasks are enumerated.

Loop per task:
1. Re-read `plans/{slug}.md` before acting; confirm current task. If multiple plan files exist, ask which one to execute.
2. Execute the task minimally; touch only listed files.
3. Update `plans/{slug}.md` status and notes immediately.
4. Run the task’s verification step if defined; record outcome.
5. When tasks change, edit the plan first (don’t improvise silently).
6. If you hit errors, branch to the matching skill: failing tests → `test-driven-development`; exceptions/tool errors → `systematic-debugging`; missing clarity → `writing-plans` or `brainstorming`. Return here once unblocked.

At end: run the plan’s verification block, summarize diffs, and hand off to finishing/verification skills.
