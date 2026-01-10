# Install via Claude Code

Copy the prompt below and paste it into Claude Code to install this configuration.

---

## Copy This Prompt

```
Install Claude Code configuration from https://github.com/jarrodwatts/claude-code-config

Fetch and install these files to ~/.claude/:

**Rules** (path-scoped instructions):
- https://raw.githubusercontent.com/jarrodwatts/claude-code-config/master/rules/typescript.md → ~/.claude/rules/typescript.md
- https://raw.githubusercontent.com/jarrodwatts/claude-code-config/master/rules/testing.md → ~/.claude/rules/testing.md
- https://raw.githubusercontent.com/jarrodwatts/claude-code-config/master/rules/comments.md → ~/.claude/rules/comments.md
- https://raw.githubusercontent.com/jarrodwatts/claude-code-config/master/rules/forge.md → ~/.claude/rules/forge.md

**Skills** (model-invoked capabilities):
- https://raw.githubusercontent.com/jarrodwatts/claude-code-config/master/skills/planning-with-files/SKILL.md → ~/.claude/skills/planning-with-files/SKILL.md
- https://raw.githubusercontent.com/jarrodwatts/claude-code-config/master/skills/planning-with-files/examples.md → ~/.claude/skills/planning-with-files/examples.md
- https://raw.githubusercontent.com/jarrodwatts/claude-code-config/master/skills/planning-with-files/reference.md → ~/.claude/skills/planning-with-files/reference.md
- https://raw.githubusercontent.com/jarrodwatts/claude-code-config/master/skills/react-useeffect/SKILL.md → ~/.claude/skills/react-useeffect/SKILL.md
- https://raw.githubusercontent.com/jarrodwatts/claude-code-config/master/skills/react-useeffect/alternatives.md → ~/.claude/skills/react-useeffect/alternatives.md
- https://raw.githubusercontent.com/jarrodwatts/claude-code-config/master/skills/react-useeffect/anti-patterns.md → ~/.claude/skills/react-useeffect/anti-patterns.md

**Agents** (custom subagents):
- https://raw.githubusercontent.com/jarrodwatts/claude-code-config/master/agents/codebase-search.md → ~/.claude/agents/codebase-search.md
- https://raw.githubusercontent.com/jarrodwatts/claude-code-config/master/agents/media-interpreter.md → ~/.claude/agents/media-interpreter.md
- https://raw.githubusercontent.com/jarrodwatts/claude-code-config/master/agents/open-source-librarian.md → ~/.claude/agents/open-source-librarian.md
- https://raw.githubusercontent.com/jarrodwatts/claude-code-config/master/agents/tech-docs-writer.md → ~/.claude/agents/tech-docs-writer.md

**Commands** (slash commands):
- https://raw.githubusercontent.com/jarrodwatts/claude-code-config/master/commands/interview.md → ~/.claude/commands/interview.md

**Hooks** (event-triggered scripts):
- https://raw.githubusercontent.com/jarrodwatts/claude-code-config/master/hooks/keyword-detector.py → ~/.claude/hooks/keyword-detector.py
- https://raw.githubusercontent.com/jarrodwatts/claude-code-config/master/hooks/check-comments.py → ~/.claude/hooks/check-comments.py
- https://raw.githubusercontent.com/jarrodwatts/claude-code-config/master/hooks/todo-enforcer.sh → ~/.claude/hooks/todo-enforcer.sh

**Global Instructions**:
- https://raw.githubusercontent.com/jarrodwatts/claude-code-config/master/CLAUDE.md → ~/.claude/CLAUDE.md

**CRITICAL: Do NOT overwrite existing files.**

Before installing each file:
1. Check if the destination file already exists
2. If it does NOT exist → install it
3. If it DOES exist → ask the user what to do:
   - **Skip**: Keep their existing file unchanged
   - **Overwrite**: Replace with the new version
   - **Merge**: Intelligently combine both versions, preserving user customizations while adding new content

This is especially important for ~/.claude/CLAUDE.md which contains personal workflow preferences. Never overwrite without explicit user consent.

Create directories as needed, fetch files with curl, and make hook scripts executable.
```

---

## What Gets Installed

| Component | Files | Description |
|-----------|-------|-------------|
| Rules | 4 | TypeScript, testing, comments, Foundry conventions |
| Skills | 2 | Planning-with-files (Manus-style workflow), React useEffect best practices |
| Agents | 4 | Codebase search, media interpreter, OSS librarian, docs writer |
| Commands | 1 | Interview (spec fleshing) |
| Hooks | 3 | Keyword detector, comment checker, todo enforcer |
| CLAUDE.md | 1 | Global instructions and workflow preferences |

## After Installation

Restart Claude Code or start a new session for changes to take effect.

To verify: ask Claude "What skills/agents are available?"
