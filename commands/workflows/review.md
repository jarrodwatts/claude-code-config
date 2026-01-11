---
allowed-tools: Read, Glob, Grep, Bash, TodoWrite
argument-hint: [review-target]
description: Workflows review: run a focused review and log findings as TodoWrite items.
---

You are invoking **workflows-review** for `$ARGUMENTS` (default: current branch diff).

1) Determine the review target:
   - If a PR URL/number or branch is provided, use that.
   - Otherwise review the current branch diff against main.
2) Collect context: key files changed, tests touched, risky areas.
3) Run review passes (correctness, security, performance, maintainability).
4) For each finding, create a TodoWrite item:
   - content: "[P1|P2|P3] <short finding> — <file/area>"
   - status: pending
5) If there are no findings, state that explicitly.

If review agents exist under `agents/review/`, dispatch the relevant ones in parallel and merge their findings into TodoWrite items.
