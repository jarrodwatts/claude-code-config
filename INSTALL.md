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
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/PlanningWithFiles/SKILL.md → ~/.claude/skills/PlanningWithFiles/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/ReactUseEffect/SKILL.md → ~/.claude/skills/ReactUseEffect/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/UsingWorkflows/SKILL.md → ~/.claude/skills/UsingWorkflows/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/Brainstorming/SKILL.md → ~/.claude/skills/Brainstorming/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/WritingPlans/SKILL.md → ~/.claude/skills/WritingPlans/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/ExecutingPlans/SKILL.md → ~/.claude/skills/ExecutingPlans/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/SubagentDrivenDevelopment/SKILL.md → ~/.claude/skills/SubagentDrivenDevelopment/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/DispatchingParallelAgents/SKILL.md → ~/.claude/skills/DispatchingParallelAgents/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/TestDrivenDevelopment/SKILL.md → ~/.claude/skills/TestDrivenDevelopment/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/VerificationBeforeCompletion/SKILL.md → ~/.claude/skills/VerificationBeforeCompletion/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/SystematicDebugging/SKILL.md → ~/.claude/skills/SystematicDebugging/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/RequestingCodeReview/SKILL.md → ~/.claude/skills/RequestingCodeReview/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/ReceivingCodeReview/SKILL.md → ~/.claude/skills/ReceivingCodeReview/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/FinishingDevelopmentBranch/SKILL.md → ~/.claude/skills/FinishingDevelopmentBranch/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/UsingGitWorktrees/SKILL.md → ~/.claude/skills/UsingGitWorktrees/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/WritingSkills/SKILL.md → ~/.claude/skills/WritingSkills/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/Compound/SKILL.md → ~/.claude/skills/Compound/SKILL.md
- https://raw.githubusercontent.com/Esk3nder/claude-code-config/main/skills/Review/SKILL.md → ~/.claude/skills/Review/SKILL.md

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
| Skills | 18 | PlanningWithFiles, ReactUseEffect, plus the Workflows pack (Brainstorming → WritingPlans → ExecutingPlans → TDD/Verification → Review/Compound → FinishingDevelopmentBranch, UsingGitWorktrees, WritingSkills) |
| Agents | 5 + 14 review | Codebase search, media interpreter, OSS librarian, oracle, docs writer + 14 code review specialists |
| Prompts | 5 | Codex expert prompts (delegator) |
| Commands | 9 | Interview, Workflows brainstorm/plan/work/review/compound, delegator setup/task/uninstall |
| Hooks | 4 | Keyword detector, comment checker, todo enforcer, require-green-tests Stop gate |
| Config | 3 | MCP config + expert mapping (reference) |
| CLAUDE.md | 1 | Global instructions and workflow preferences |

## After Installation

Restart Claude Code or start a new session for changes to take effect.

To verify: ask Claude "What skills/agents are available?"
