---
allowed-tools: Read, Glob, Grep, Write, Edit
argument-hint: [plan-file]
description: Workflows plan writer: create or update a short, verifiable task plan in the given file.
---

You are invoking **workflows-writing-plans**. Target file: `$ARGUMENTS` (default `plans/{slug}.md`).

If `$ARGUMENTS` is empty:
- Derive `{slug}` from the goal: lowercase, hyphen-separated, 3–6 words max, prefixed with `YYYYMMDD-`.
- Ensure `plans/` exists before writing.

1) Ensure the file exists; create headers: Goal, Constraints, Tasks, Verification.
2) List 4–8 tasks max; each task = action + files + check box + verification.
3) Add overall verification block (tests/linters/manual) and owners if relevant.
4) Keep tasks small and ordered; avoid vague placeholders.
