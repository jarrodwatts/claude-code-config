---
name: ExecutingPlans
description: Default executor for written plans; iterate tasks and keep plan in sync. USE WHEN plan exists OR tasks enumerated OR continuing workflow.
---

# ExecutingPlans

Execute tasks from a plan file systematically.

## Workflow Routing

| Workflow | Trigger | File |
|----------|---------|------|
| **Execute** | "execute plan", "work on plan", "continue" | Inline |

## Process

Loop per task:
1. Re-read `plans/{slug}.md` before acting; confirm current task.
2. Execute the task minimally; touch only listed files.
3. Update `plans/{slug}.md` status and notes immediately.
4. Run the task's verification step if defined; record outcome.
5. When tasks change, edit the plan first (don't improvise silently).
6. On errors, branch to matching skill:
   - Failing tests → `TestDrivenDevelopment`
   - Exceptions/tool errors → `SystematicDebugging`
   - Missing clarity → `WritingPlans` or `Brainstorming`

At end: run verification block, summarize diffs, hand off to finishing skills.

## Examples

**Example 1: Continue workflow**
```
User: "/workflows/work"
→ Invokes ExecutingPlans
→ Reads plan, picks next unchecked task
→ Executes and updates status
```

**Example 2: Resume after error**
```
User: "Continue with the plan"
→ Re-reads plan file
→ Finds current task, resumes execution
```
