---
allowed-tools: Read, Glob, Grep, Write, Edit
argument-hint: [context]
description: Workflows compound: capture solved problems into docs/solutions for future reuse.
---

You are invoking **workflows-compound**. Context: `$ARGUMENTS` (default: current task/plan).

1) Identify the problem, root cause, fix, and verification steps.
2) Choose a category and write to `docs/solutions/<category>/<slug>.md` (create dirs as needed).
3) Include YAML frontmatter: title, date, tags, related_plans.
4) Keep it concise and searchable; link to the relevant plan file.

Suggested categories:
- build-errors
- performance-issues
- security-issues
- database-issues
- api-issues
- frontend-issues
- config-issues
