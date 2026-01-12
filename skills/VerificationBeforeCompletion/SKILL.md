---
name: VerificationBeforeCompletion
description: Run required checks and block delivery until they pass. USE WHEN finishing task OR before PR OR claiming completion OR lint/type errors.
---

# VerificationBeforeCompletion

Verify before claiming done.

## Workflow Routing

| Workflow | Trigger | File |
|----------|---------|------|
| **Verify** | "done", "complete", "ready" | Inline |

## Checklist

1. Run the project's canonical test command.
2. Run lint/typecheck/format as applicable.
3. For UI/API changes, perform a quick manual check or curl hit.
4. Summarize results in handoff: commands run, status, notable failures.
5. If any check fails, route to the right skill:
   - Tests → `TestDrivenDevelopment`
   - Exceptions/tool errors → `SystematicDebugging`
   - Plan gaps → `WritingPlans`/`ExecutingPlans`

Do not claim completion until green or explicitly waived.

## Examples

**Example 1: Task completion**
```
User: "I think I'm done"
→ Invokes VerificationBeforeCompletion
→ Runs tests, lint, typecheck
→ Reports results
```

**Example 2: Check fails**
```
User: (lint errors found)
→ Blocks completion
→ Routes to fix, then returns
```
