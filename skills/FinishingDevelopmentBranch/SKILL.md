---
name: FinishingDevelopmentBranch
description: Finalize a branch safely with clean tree, green checks, and merge readiness. USE WHEN work is done OR preparing to merge OR creating PR.
---

# FinishingDevelopmentBranch

Prepare a branch for merge.

## Workflow Routing

| Workflow | Trigger | File |
|----------|---------|------|
| **Finish** | "done with feature", "ready to merge", "finish branch" | Inline |

## Checklist

1. Ensure working tree clean; no stray debug files.
2. Tests/linters green (or documented exception).
3. Update docs/changelog if behavior visible to users.
4. Summarize changes, risks, and verification for reviewer.
5. Rebase/sync with main if needed; resolve conflicts.
6. Hand off with PR-ready notes and link to test results.

## Examples

**Example 1: Feature complete**
```
User: "I'm done with this feature branch"
→ Invokes FinishingDevelopmentBranch
→ Runs checklist: tests, lint, clean tree
→ Prepares PR summary
```

**Example 2: Pre-merge check**
```
User: "Help me finish up before merging"
→ Validates all checks pass
→ Creates handoff notes
```
