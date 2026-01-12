---
name: Compound
description: Capture solved problems as categorized documentation with YAML frontmatter. USE WHEN problem solved OR "that worked" OR "it's fixed" OR documenting solutions.
allowed-tools:
  - Read
  - Write
  - Bash
  - Grep
---

# Compound

Document solved problems to build searchable institutional knowledge.

## Workflow Routing

| Workflow | Trigger | File |
|----------|---------|------|
| **Capture** | "document fix", "compound", "that worked" | Inline |

## When to Invoke

**Auto-trigger phrases:**
- "that worked"
- "it's fixed"
- "working now"
- "problem solved"

**Non-trivial problems only** - skip simple typos.

## Process

1. Detect confirmation phrase or `/workflows/compound` command
2. Gather context: symptom, investigation attempts, root cause, solution, prevention
3. Check existing docs: `grep -r "error phrase" docs/solutions/`
4. Generate filename: `[sanitized-symptom]-[YYYYMMDD].md`
5. Validate category (build-errors, test-failures, performance-issues, etc.)
6. Create documentation in `docs/solutions/[category]/`
7. Cross-reference if similar issues found

## Examples

**Example 1: Bug fix documentation**
```
User: "That worked! The N+1 query is fixed."
→ Invokes Compound
→ Creates docs/solutions/performance-issues/n-plus-one-fix-20260112.md
→ Includes root cause and prevention
```

**Example 2: Config issue**
```
User: "Finally working now"
→ Invokes Compound
→ Documents the config change
→ Links to related issues
```
