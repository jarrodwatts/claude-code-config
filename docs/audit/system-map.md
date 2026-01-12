# System Map

**Generated**: 2026-01-11

## Overview

This document maps how user requests flow through the Claude Code configuration system, from input to execution.

## Input Types

| Input Type | Example | Handler |
|------------|---------|---------|
| Natural language | "Help me debug this" | Skills (context-matched) |
| Slash command | `/plan`, `/review` | Commands (explicit) |
| Workflow keyword | "ultrawork", "delegate" | keyword-detector.py hook |
| Code edit | Edit/Write tool use | check-comments.py hook |
| Session stop | User stops or task completes | Stop hooks |

## Routing Architecture

### 1. Skills (Model-Invoked)

Skills are discovered by Claude Code scanning `~/.claude/skills/*/SKILL.md`. Each skill contains:
- Activation criteria (context patterns)
- Instructions for the model
- Supporting reference files

**Routing**: Implicit via model context matching. No explicit dispatcher.

| Skill | Activation Context |
|-------|-------------------|
| planning-with-files | Plan-based development, `plans/` directory |
| react-useeffect | React hooks, useEffect patterns |
| using-workflows | Workflow commands mentioned |
| brainstorming | Ideation, exploration tasks |
| writing-plans | Creating implementation plans |
| executing-plans | Following existing plans |
| subagent-driven-development | Complex multi-step tasks |
| dispatching-parallel-agents | Parallel agent coordination |
| test-driven-development | TDD workflow |
| verification-before-completion | Pre-completion checks |
| systematic-debugging | Bug investigation |
| requesting-code-review | Review request workflow |
| receiving-code-review | Handling review feedback |
| finishing-a-development-branch | Branch completion workflow |
| using-git-worktrees | Git worktree management |
| writing-skills | Creating new skills |

### 2. Commands (User-Invoked)

Commands are discovered by Claude Code scanning `~/.claude/commands/**/*.md`. Triggered by `/command-name` syntax.

| Command | Path | Purpose |
|---------|------|---------|
| `/interview` | commands/interview.md | Requirements gathering |
| `/workflows/brainstorm` | commands/workflows/brainstorm.md | Ideation workflow |
| `/workflows/plan` | commands/workflows/plan.md | Planning workflow |
| `/workflows/work` | commands/workflows/work.md | Implementation workflow |
| `/workflows/review` | commands/workflows/review.md | Code review workflow |
| `/workflows/compound` | commands/workflows/compound.md | Multi-phase workflow |
| `/claude-delegator/setup` | commands/claude-delegator/setup.md | Delegator installation |
| `/claude-delegator/task` | commands/claude-delegator/task.md | Codex delegation |
| `/claude-delegator/uninstall` | commands/claude-delegator/uninstall.md | Delegator removal |

### 3. Hooks (Event-Triggered)

Hooks are configured in `~/.claude/settings.json` under the `hooks` key. They intercept lifecycle events.

| Event | Hook | Trigger Condition | Effect |
|-------|------|-------------------|--------|
| UserPromptSubmit | keyword-detector.py | Always | Injects workflow guidance |
| PostToolUse | check-comments.py | Tool matches `Write\|Edit` | Validates comment ratio |
| Stop | require-green-tests.sh | Always | Blocks if tests fail |
| Stop | todo-enforcer.sh | Always | Blocks if todos incomplete |

### 4. Agents (Delegated Work)

Agents are custom subagent configurations discovered from `~/.claude/agents/**/*.md`.

| Agent | Purpose |
|-------|---------|
| codebase-search | Internal codebase exploration |
| media-interpreter | Image/media analysis |
| open-source-librarian | External library research |
| oracle | High-stakes architecture and debugging |
| tech-docs-writer | Documentation generation |
| review/* (14 specialists) | Domain-specific code review |

### 5. Rules (Path-Scoped Instructions)

Rules are loaded based on file path patterns from `~/.claude/rules/**/*.md`.

| Rule | Scope |
|------|-------|
| typescript.md | TypeScript files |
| testing.md | Test files |
| comments.md | All code files |
| forge.md | Foundry/Solidity projects |
| delegator/*.md | Codex delegation |

### 6. Prompts (Codex Experts)

Prompts define expert personas for Codex MCP delegation. Mapped via `config/delegator/experts.json`.

| Expert | Prompt | Native Agent |
|--------|--------|--------------|
| architect | architect.md | architecture-strategist |
| plan-reviewer | plan-reviewer.md | writing-plans, planning-with-files |
| scope-analyst | scope-analyst.md | interview command |
| code-reviewer | code-reviewer.md | code-simplicity, pattern-recognition |
| security-analyst | security-analyst.md | security-sentinel |

## Hook Wiring Configuration

Required `~/.claude/settings.json` snippet:

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

## Environment Variables

| Variable | Used By | Purpose | Default |
|----------|---------|---------|---------|
| WORKFLOWS_TEST_CMD | require-green-tests.sh | Override test command | Auto-detected |
| SUPERPOWERS_TEST_CMD | require-green-tests.sh | Legacy alias | - |
| WORKFLOWS_TEST_MAX_OUTPUT_LINES | require-green-tests.sh | Truncate printed test output | 200 |
| REPO_ROOT | All hooks | Repository root path | `git rev-parse --show-toplevel` |

## State Files

| File | Purpose | Created By |
|------|---------|------------|
| `.claude/.state/last_tests.env` | Test result cache | require-green-tests.sh |
| `plans/*.md` | Implementation plans | writing-plans skill |

## Error/Stop Paths

### Stop Hook Behavior

1. **require-green-tests.sh**:
   - Detects test framework (pnpm/yarn/npm via lockfile)
   - Runs `$TEST_CMD test` or user-specified command
   - Caches passing results to avoid re-running
   - Blocks exit with guidance message if tests fail

2. **todo-enforcer.sh**:
   - Checks for incomplete todo items
   - Blocks exit if todos remain
   - Safety valve: allows exit after 10 consecutive blocks

### Hook Failure Modes

| Failure | Hook | User Experience |
|---------|------|-----------------|
| Tests fail | require-green-tests.sh | Exit blocked, message shown |
| Todos incomplete | todo-enforcer.sh | Exit blocked, message shown |
| jq missing | todo-enforcer.sh | Logs error and allows exit (no user-facing warning) |
| Python missing | keyword-detector.py | Hook fails silently |
| Invalid JSON in tool output | check-comments.py | Attempts repair, may fail |
