---
name: ReceivingCodeReview
description: Process reviewer feedback systematically and update code. USE WHEN feedback received OR review comments OR addressing PR comments.
---

# ReceivingCodeReview

Process reviewer feedback methodically.

## Workflow Routing

| Workflow | Trigger | File |
|----------|---------|------|
| **ProcessFeedback** | "address feedback", "fix review comments" | Inline |

## Process

1. Triage comments: group by theme and severity.
2. Apply quick fixes first; note any deferred items with owner/date.
3. For disagreements, propose an alternative and respond concisely.
4. Re-run tests relevant to touched areas.
5. Update handoff note with what changed and what remains.

## Examples

**Example 1: Multiple comments**
```
User: "Address the review feedback"
→ Invokes ReceivingCodeReview
→ Groups comments by theme
→ Applies fixes systematically
```

**Example 2: Disagreement**
```
User: "I disagree with the reviewer's suggestion"
→ Helps formulate alternative proposal
→ Provides concise reasoning
```
