---
name: workflows-using-workflows
description: Always check and invoke relevant Workflows skills before acting; ensures deterministic routing and avoids ad‑hoc workflows.
---

# Using Workflows

Before any non-trivial reply:
1. Pause and scan: does this map to brainstorming, planning, executing, debugging, testing, review, or finishing?
2. Route to the highest-priority matching skill (brainstorm → plan → persist → work → debug → test → verify → review → finish).
3. On **errors/failures**, auto-route:
   - Test failure → `test-driven-development`
   - Lint/type failure → `verification-before-completion`
   - Exception/tool/API failure → `systematic-debugging`
   - Plan drift/unclear next step → `writing-plans` then `executing-plans`
4. If none apply, state why and proceed minimally.

Always note which skill you’re following in your first reasoning step to keep routing deterministic.
