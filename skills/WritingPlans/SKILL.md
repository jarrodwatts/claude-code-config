---
name: WritingPlans
description: Produce short, verifiable task plans with files and checks. USE WHEN tasks span multiple steps OR files OR need structured approach.
---

# WritingPlans

Create structured plans in `plans/{slug}.md`.

## Workflow Routing

| Workflow | Trigger | File |
|----------|---------|------|
| **CreatePlan** | "plan", "break down", "steps" | Inline |

## Process

1. Create or update `plans/{slug}.md` in the working directory.
   - Ensure `plans/` exists
   - Derive `{slug}` from the goal (lowercase, hyphen-separated, 3–6 words)
   - Prefix with `YYYYMMDD-`
2. Capture: goal (1 line), constraints, and success criteria.
3. List 4–8 tasks max, each with: action, target files, and verification/check.
4. Mark status boxes `[ ]` initially; keep tasks small and ordered.
5. Add a verification block (tests, linters, manual checks) to run before finishing.
6. If research needed, add `notes.md` pointer (PlanningWithFiles will manage persistence).

## Examples

**Example 1: Feature planning**
```
User: "Plan the user authentication feature"
→ Invokes WritingPlans
→ Creates plans/20260112-user-auth.md
→ Lists 5 tasks with verification steps
```

**Example 2: Bug fix plan**
```
User: "Break down fixing this complex bug"
→ Creates plan with investigation and fix steps
→ Includes repro verification
```
