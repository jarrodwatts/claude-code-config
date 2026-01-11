---
name: workflows-verification-before-completion
description: Run required checks (tests, lint, typecheck, manual QA) and block delivery until they pass.
---

# Verification Before Completion

Use before finishing any task or PR.

Checklist:
1. Run the project’s canonical test command.
2. Run lint/typecheck/format as applicable.
3. For UI/API changes, perform a quick manual check or curl hit.
4. Summarize results in the handoff: commands run, status, notable failures.
5. If any check fails, route to the right skill: tests → `test-driven-development`; exceptions/tool errors → `systematic-debugging`; plan gaps → `writing-plans`/`executing-plans`. Do not claim completion until green or explicitly waived.
