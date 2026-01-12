---
name: Review
description: Multi-agent code review with parallel analysis. USE WHEN PR URL mentioned OR "review this" OR "check my changes" OR before merge.
---

# Review

Comprehensive code review using multi-agent analysis.

## Workflow Routing

| Workflow | Trigger | File |
|----------|---------|------|
| **CodeReview** | "review", "check changes", PR URL | Inline |

## Process

1. Determine review target:
   - PR URL/number provided → use that
   - Branch specified → review that branch
   - Otherwise → review current branch diff against main

2. Collect context:
   - Key files changed
   - Tests touched
   - Risky areas (auth, payments, migrations, concurrency)

3. Run parallel review agents:
   - security-sentinel
   - performance-oracle
   - architecture-strategist

4. Synthesize findings by severity:
   - P1/Critical → blocks merge
   - P2/Important → should fix
   - P3/Nice-to-have → optional

5. Create TodoWrite items for each finding

## Examples

**Example 1: PR review**
```
User: "Review PR #123"
→ Invokes Review
→ Spawns parallel review agents
→ Aggregates findings with severity
```

**Example 2: Pre-merge check**
```
User: "Review my changes before merging"
→ Reviews current branch diff
→ Creates TodoWrite items for issues
```
