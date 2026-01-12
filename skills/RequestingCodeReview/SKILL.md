---
name: RequestingCodeReview
description: Prepare reviewer-friendly summary and checklist before review. USE WHEN requesting review OR preparing PR OR handing off work.
---

# RequestingCodeReview

Prepare a concise review request.

## Workflow Routing

| Workflow | Trigger | File |
|----------|---------|------|
| **PrepareReview** | "request review", "prepare PR" | Inline |

## Checklist

1. Summarize scope in 3–5 bullets (what/why/risks).
2. Point reviewers to key files/commits and known tricky areas.
3. State verification done (tests/linters/manual) and link to results.
4. Call out follow-ups/debt explicitly.
5. Keep the ask focused (e.g., correctness, API shape, perf).

## Examples

**Example 1: Feature PR**
```
User: "Help me prepare this PR for review"
→ Invokes RequestingCodeReview
→ Creates summary with scope, risks, verification
→ Highlights key files and tricky areas
```

**Example 2: Focused review**
```
User: "I want them to focus on the API design"
→ Creates targeted review request
→ Points to specific files and decisions
```
