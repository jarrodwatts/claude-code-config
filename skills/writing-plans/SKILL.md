---
name: workflows-writing-plans
description: Produce a short, verifiable task plan with files and checks, written to plans/{slug}.md; pairs with planning-with-files for persistence.
---

# Writing Plans

Use when tasks span multiple steps or files.

Steps:
1. Create or update `plans/{slug}.md` in the working directory (single source of truth). Ensure `plans/` exists; derive `{slug}` from the goal (lowercase, hyphen-separated, 3–6 words) and prefix with `YYYYMMDD-`.
2. Capture: goal (1 line), constraints, and success criteria.
3. List 4–8 tasks max, each with: action, target files, and a verification/check.
4. Mark status boxes `[ ]` initially; keep tasks small and ordered.
5. Add a verification block (tests, linters, manual checks) to run before finishing.
6. If research is needed, add `notes.md` pointer (planning-with-files will manage persistence).
