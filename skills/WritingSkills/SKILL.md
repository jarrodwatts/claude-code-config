---
name: WritingSkills
description: Author or update skills with clear triggers, steps, and outcomes. USE WHEN creating skills OR editing SKILL.md OR skill mentioned.
---

# WritingSkills

Create skills that Claude can invoke deterministically.

## Workflow Routing

| Workflow | Trigger | File |
|----------|---------|------|
| **CreateSkill** | "create skill", "new skill" | Inline |
| **UpdateSkill** | "update skill", "fix skill" | Inline |

## Guidelines

1. Frontmatter: unique `name` (TitleCase), concise `description` with `USE WHEN` clause.
2. Body: 5–10 steps max; emphasize when to trigger and when *not* to.
3. Include `## Workflow Routing` table and `## Examples` section.
4. Create `Tools/` directory (even if empty).
5. Avoid ambiguity—state required artifacts (files, outputs) explicitly.
6. Keep tasks small; prefer checklists to prose.
7. Note interactions with other skills to reduce collisions.
8. Test by prompting with realistic tasks and confirming the right skill fires.

## Examples

**Example 1: New skill**
```
User: "Create a skill for database migrations"
→ Invokes WritingSkills
→ Creates DatabaseMigrations/ with SKILL.md and Tools/
→ Includes USE WHEN clause and examples
```

**Example 2: Fix skill**
```
User: "Canonicalize the review skill"
→ Renames to TitleCase
→ Adds missing Examples section
```
