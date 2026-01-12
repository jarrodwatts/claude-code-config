---
name: UsingWorkflows
description: Check and invoke relevant workflow skills before acting. USE WHEN starting any non-trivial task OR routing needed OR unclear which skill applies.
---

# UsingWorkflows

Route to the correct workflow skill deterministically.

## Workflow Routing

| Workflow | Trigger | File |
|----------|---------|------|
| **Route** | Any non-trivial task | Inline |

## Process

Before any non-trivial reply:
1. Pause and scan: does this map to brainstorming, planning, executing, debugging, testing, review, or finishing?
2. Route to highest-priority matching skill:
   - Brainstorming → WritingPlans → PlanningWithFiles → ExecutingPlans → SystematicDebugging → TestDrivenDevelopment → VerificationBeforeCompletion → Review → FinishingDevelopmentBranch
3. On errors/failures, auto-route:
   - Test failure → `TestDrivenDevelopment`
   - Lint/type failure → `VerificationBeforeCompletion`
   - Exception/tool failure → `SystematicDebugging`
   - Plan drift → `WritingPlans` then `ExecutingPlans`
4. If none apply, state why and proceed minimally.

Always note which skill you're following to keep routing deterministic.

## Examples

**Example 1: Unclear task**
```
User: "Help me with this feature"
→ Invokes UsingWorkflows
→ Routes to Brainstorming or WritingPlans based on clarity
```

**Example 2: Error encountered**
```
User: (test fails during execution)
→ Auto-routes to TestDrivenDevelopment
→ Returns to ExecutingPlans after fix
```
