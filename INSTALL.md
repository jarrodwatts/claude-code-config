# Install via Claude Code

## Quick Install (Recommended)

```bash
git clone https://github.com/Esk3nder/claude-code-config.git /tmp/claude-config
cd /tmp/claude-config && ./install.sh
```

## Manual Install via Claude Code

Alternatively, copy the prompt below and paste it into Claude Code to install this configuration.

---

## Copy This Prompt

```
Install Claude Code configuration from https://github.com/Esk3nder/claude-code-config

Fetch and install these files to ~/.claude/:

**Rules** (path-scoped instructions):
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/rules/typescript.md → ~/.claude/rules/typescript.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/rules/testing.md → ~/.claude/rules/testing.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/rules/comments.md → ~/.claude/rules/comments.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/rules/forge.md → ~/.claude/rules/forge.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/rules/delegator/orchestration.md → ~/.claude/rules/delegator/orchestration.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/rules/delegator/triggers.md → ~/.claude/rules/delegator/triggers.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/rules/delegator/model-selection.md → ~/.claude/rules/delegator/model-selection.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/rules/delegator/delegation-format.md → ~/.claude/rules/delegator/delegation-format.md

**Skills** (model-invoked capabilities):
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/planning-with-files/SKILL.md → ~/.claude/skills/planning-with-files/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/planning-with-files/examples.md → ~/.claude/skills/planning-with-files/examples.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/planning-with-files/reference.md → ~/.claude/skills/planning-with-files/reference.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/react-useeffect/SKILL.md → ~/.claude/skills/react-useeffect/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/react-useeffect/alternatives.md → ~/.claude/skills/react-useeffect/alternatives.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/react-useeffect/anti-patterns.md → ~/.claude/skills/react-useeffect/anti-patterns.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/using-workflows/SKILL.md → ~/.claude/skills/using-workflows/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/brainstorming/SKILL.md → ~/.claude/skills/brainstorming/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/writing-plans/SKILL.md → ~/.claude/skills/writing-plans/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/executing-plans/SKILL.md → ~/.claude/skills/executing-plans/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/subagent-driven-development/SKILL.md → ~/.claude/skills/subagent-driven-development/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/dispatching-parallel-agents/SKILL.md → ~/.claude/skills/dispatching-parallel-agents/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/test-driven-development/SKILL.md → ~/.claude/skills/test-driven-development/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/verification-before-completion/SKILL.md → ~/.claude/skills/verification-before-completion/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/systematic-debugging/SKILL.md → ~/.claude/skills/systematic-debugging/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/requesting-code-review/SKILL.md → ~/.claude/skills/requesting-code-review/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/receiving-code-review/SKILL.md → ~/.claude/skills/receiving-code-review/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/finishing-a-development-branch/SKILL.md → ~/.claude/skills/finishing-a-development-branch/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/using-git-worktrees/SKILL.md → ~/.claude/skills/using-git-worktrees/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/writing-skills/SKILL.md → ~/.claude/skills/writing-skills/SKILL.md

**Agents** (custom subagents):
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/agents/codebase-search.md → ~/.claude/agents/codebase-search.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/agents/media-interpreter.md → ~/.claude/agents/media-interpreter.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/agents/open-source-librarian.md → ~/.claude/agents/open-source-librarian.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/agents/oracle.md → ~/.claude/agents/oracle.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/agents/tech-docs-writer.md → ~/.claude/agents/tech-docs-writer.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/agents/review/index.md → ~/.claude/agents/review/index.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/agents/review/security-sentinel.md → ~/.claude/agents/review/security-sentinel.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/agents/review/performance-oracle.md → ~/.claude/agents/review/performance-oracle.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/agents/review/architecture-strategist.md → ~/.claude/agents/review/architecture-strategist.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/agents/review/data-migration-expert.md → ~/.claude/agents/review/data-migration-expert.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/agents/review/deployment-verification.md → ~/.claude/agents/review/deployment-verification.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/agents/review/code-simplicity.md → ~/.claude/agents/review/code-simplicity.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/agents/review/data-integrity-guardian.md → ~/.claude/agents/review/data-integrity-guardian.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/agents/review/pattern-recognition.md → ~/.claude/agents/review/pattern-recognition.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/agents/review/agent-native.md → ~/.claude/agents/review/agent-native.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/agents/review/typescript.md → ~/.claude/agents/review/typescript.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/agents/review/rails.md → ~/.claude/agents/review/rails.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/agents/review/python.md → ~/.claude/agents/review/python.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/agents/review/dhh-rails.md → ~/.claude/agents/review/dhh-rails.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/agents/review/frontend-races.md → ~/.claude/agents/review/frontend-races.md

**Prompts** (Codex expert prompts):
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/prompts/delegator/architect.md → ~/.claude/prompts/delegator/architect.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/prompts/delegator/plan-reviewer.md → ~/.claude/prompts/delegator/plan-reviewer.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/prompts/delegator/scope-analyst.md → ~/.claude/prompts/delegator/scope-analyst.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/prompts/delegator/code-reviewer.md → ~/.claude/prompts/delegator/code-reviewer.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/prompts/delegator/security-analyst.md → ~/.claude/prompts/delegator/security-analyst.md

**Commands** (slash commands):
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/commands/interview.md → ~/.claude/commands/interview.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/commands/workflows/brainstorm.md → ~/.claude/commands/workflows/brainstorm.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/commands/workflows/plan.md → ~/.claude/commands/workflows/plan.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/commands/workflows/work.md → ~/.claude/commands/workflows/work.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/commands/workflows/review.md → ~/.claude/commands/workflows/review.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/commands/workflows/compound.md → ~/.claude/commands/workflows/compound.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/commands/claude-delegator/setup.md → ~/.claude/commands/claude-delegator/setup.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/commands/claude-delegator/task.md → ~/.claude/commands/claude-delegator/task.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/commands/claude-delegator/uninstall.md → ~/.claude/commands/claude-delegator/uninstall.md

**Hooks** (event-triggered scripts):
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/hooks/keyword-detector.py → ~/.claude/hooks/keyword-detector.py
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/hooks/check-comments.py → ~/.claude/hooks/check-comments.py
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/hooks/todo-enforcer.sh → ~/.claude/hooks/todo-enforcer.sh
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/hooks/workflows/require-green-tests.sh → ~/.claude/hooks/workflows/require-green-tests.sh

**Config** (reference snippets):
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/config/delegator/mcp-servers.example.json → ~/.claude/config/delegator/mcp-servers.example.json
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/config/delegator/providers.json → ~/.claude/config/delegator/providers.json
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/config/delegator/experts.json → ~/.claude/config/delegator/experts.json

**Hook wiring (`~/.claude/settings.json`)**
Add or merge this snippet so the hooks actually run:
```json
{
  "hooks": {
    "UserPromptSubmit": [
      { "hooks": [{ "type": "command", "command": "./hooks/keyword-detector.py" }] }
    ],
    "PostToolUse": [
      { "matcher": "Write|Edit", "hooks": [{ "type": "command", "command": "./hooks/check-comments.py" }] }
    ],
    "Stop": [
      { "hooks": [{ "type": "command", "command": "./hooks/workflows/require-green-tests.sh" }] },
      { "hooks": [{ "type": "command", "command": "./hooks/todo-enforcer.sh" }] }
    ]
  }
}
```
Set `WORKFLOWS_TEST_CMD` to override the test command used by the Stop gate (legacy `SUPERPOWERS_TEST_CMD` still works).

**Global Instructions**:
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/CLAUDE.md → ~/.claude/CLAUDE.md

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
| Rules | 8 | TypeScript/testing/comments/Foundry + delegator orchestration |
| Skills | 16 | Planning-with-files, React useEffect, plus the Workflows pack (brainstorm → plan → work → TDD/verification → review → finish, worktrees, writing-skills) |
| Agents | 5 + 14 review | Codebase search, media interpreter, OSS librarian, oracle, docs writer + 14 code review specialists |
| Prompts | 5 | Codex expert prompts (delegator) |
| Commands | 9 | Interview, Workflows brainstorm/plan/work/review/compound, delegator setup/task/uninstall |
| Hooks | 4 | Keyword detector, comment checker, todo enforcer, require-green-tests Stop gate |
| Config | 3 | MCP config + expert mapping (reference) |
| CLAUDE.md | 1 | Global instructions and workflow preferences |

## After Installation

Restart Claude Code or start a new session for changes to take effect.

To verify: ask Claude "What skills/agents are available?"
