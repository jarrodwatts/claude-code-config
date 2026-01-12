---
name: Brainstorming
description: Generate options, constraints, risks, and selection rationale. USE WHEN request is unclear OR design-heavy OR multiple approaches exist.
---

# Brainstorming

Generate options before committing to a solution.

## Workflow Routing

| Workflow | Trigger | File |
|----------|---------|------|
| **Brainstorm** | "brainstorm", "options", "approaches", "how should we" | Inline |

## Process

1. Restate goal and constraints in 2–3 bullets.
2. List 5–7 distinct options; mix conservative and bold approaches.
3. Note pros, cons, and risks for each (keep tight).
4. Pick a recommendation with rationale and next validation step.
5. Capture open questions to resolve before building.

## Examples

**Example 1: Architecture decision**
```
User: "How should we implement caching for the API?"
→ Invokes Brainstorming
→ Lists options: Redis, in-memory, CDN, hybrid
→ Recommends with rationale
```

**Example 2: Feature design**
```
User: "What's the best approach for user notifications?"
→ Invokes Brainstorming
→ Lists: push, email, in-app, SMS, webhooks
→ Weighs pros/cons, picks recommendation
```
