---
name: TestDrivenDevelopment
description: Follow RED→GREEN→REFACTOR cycle. USE WHEN adding behavior OR fixing bugs OR writing tests OR test mentioned.
---

# TestDrivenDevelopment

Write failing test first, then minimal code to pass.

## Workflow Routing

| Workflow | Trigger | File |
|----------|---------|------|
| **TDD** | "add test", "fix bug", "test first" | Inline |

## Cycle

1. Write/adjust a test that captures the expected behavior.
2. Run tests and confirm the new test fails for the right reason.
3. Implement the minimal change to pass.
4. Re-run tests; ensure all green.
5. Refactor for clarity; keep tests green.
6. Document commands used and outcomes in `plans/{slug}.md` or commit notes.

## Examples

**Example 1: New feature**
```
User: "Add email validation function"
→ Invokes TestDrivenDevelopment
→ Writes test for valid/invalid emails first
→ Implements minimal validation to pass
```

**Example 2: Bug fix**
```
User: "Fix the off-by-one error"
→ Writes test that exposes the bug
→ Confirms test fails
→ Fixes and confirms green
```
