---
name: PlanningWithFiles
description: Use persistent markdown files for planning and progress tracking. USE WHEN starting complex tasks OR multi-step projects OR user mentions planning OR organizing work.
---

# PlanningWithFiles

Work like Manus: Use persistent markdown files as working memory on disk.

## Workflow Routing

| Workflow | Trigger | File |
|----------|---------|------|
| **CreatePlan** | "plan this", "start planning" | Inline |
| **UpdatePlan** | "update plan", "mark done" | Inline |

## Quick Start

Before ANY complex task:

1. **Create `plans/{slug}.md`** in the working directory (ensure `plans/` exists)
2. **Define phases** with checkboxes
3. **Update after each phase** - mark [x] and change status
4. **Read before deciding** - refresh goals in attention window

## The 3-File Pattern

- `plans/{slug}.md` - Task plan with checkboxes
- `notes.md` - Research and findings
- `docs/solutions/` - Captured solutions

## Examples

**Example 1: New feature**
```
User: "Build a user dashboard"
→ Invokes PlanningWithFiles
→ Creates plans/user-dashboard.md
→ Defines phases with verification steps
```

**Example 2: Research task**
```
User: "Investigate the performance issue"
→ Creates plan with investigation steps
→ Captures findings in notes.md
```
