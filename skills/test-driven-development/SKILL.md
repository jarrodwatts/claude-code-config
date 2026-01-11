---
name: workflows-test-driven-development
description: Follow RED→GREEN→REFACTOR; write the failing test first, then minimal code to pass, then cleanup.
---

# Test-Driven Development

Use when adding behavior or fixing a bug.

Cycle:
1. Write/adjust a test that captures the expected behavior.
2. Run tests and confirm the new test fails for the right reason.
3. Implement the minimal change to pass.
4. Re-run tests; ensure all green.
5. Refactor for clarity; keep tests green.
6. Document commands used and outcomes in `plans/{slug}.md` or commit notes.
