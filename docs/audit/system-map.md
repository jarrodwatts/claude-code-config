# System Map

**Last Updated:** 2026-01-12 (Pass 2)

## Overview

This document provides a comprehensive inventory of the Claude Code configuration system, documenting all components, their relationships, and verified invariants.

---

## Entry Points

| ID | Label | Event | Evidence |
|----|-------|-------|----------|
| entry:user-prompt | User Prompt | User submits text | Claude Code runtime |
| entry:slash-command | Slash Command | User invokes `/command` | Claude Code /command syntax |
| entry:tool-use | Tool Invocation | Model calls a tool | Claude Code tool calls |
| entry:session-stop | Session Stop | User exits or task completes | User action |

---

## Lifecycle Hooks

| ID | File | Event | Blocking | Trigger |
|----|------|-------|----------|---------|
| hook:keyword-detector | `hooks/keyword-detector.py` | UserPromptSubmit | No | Always |
| hook:check-comments | `hooks/check-comments.py` | PostToolUse | No | Write\|Edit |
| hook:require-green-tests | `hooks/workflows/require-green-tests.sh` | Stop | Yes | Always |
| hook:todo-enforcer | `hooks/todo-enforcer.sh` | Stop | Yes | Always |

### Hook Behavior Details

**keyword-detector.py** (140 lines)
- Detects 5 keyword patterns: ultrawork, delegation, search, analysis, think
- Outputs: `hookSpecificOutput.additionalContext` (context injection, not dispatch)
- Does NOT dispatch agents/skills directly

**check-comments.py** (233 lines)
- Analyzes code for comment ratio (threshold: 25%)
- Validates against allowlist of valid comment patterns (BDD, JSDoc, pragmas, etc.)
- Outputs warning in `hookSpecificOutput.additionalContext` if excessive

**require-green-tests.sh** (233 lines)
- Auto-detects test command from lock files (npm/yarn/pnpm/bun/pytest/cargo/etc.)
- Caches results using mtime comparison (GAP-004: TOCTOU risk)
- Validates override commands against allowlist
- Blocks completion if tests fail

**todo-enforcer.sh** (145 lines)
- Parses transcript for TodoWrite tool calls
- Blocks if pending/in_progress todos exist
- Safety valve: allows exit after 10 consecutive blocks
- Requires jq (GAP-009: fails silently if missing)

---

## Commands (Slash Commands)

| ID | Command | Allowed Tools | Evidence |
|----|---------|---------------|----------|
| cmd:interview | /interview | AskUserQuestion, Read, Glob, Grep, Write, Edit | commands/interview.md |
| cmd:workflows-brainstorm | /workflows/brainstorm | AskUserQuestion, Read, Glob, Grep | commands/workflows/brainstorm.md |
| cmd:workflows-plan | /workflows/plan | Read, Glob, Grep, Write, Edit | commands/workflows/plan.md |
| cmd:workflows-work | /workflows/work | Read, Glob, Grep, Write, Edit, Bash | commands/workflows/work.md |
| cmd:workflows-review | /workflows/review | Read, Glob, Grep, Bash, TodoWrite, Task | commands/workflows/review.md |
| cmd:workflows-compound | /workflows/compound | Read, Glob, Grep, Write, Edit | commands/workflows/compound.md |
| cmd:delegator-setup | /claude-delegator/setup | (setup actions) | commands/claude-delegator/setup.md |
| cmd:delegator-task | /claude-delegator/task | Read, AskUserQuestion, Bash, mcp__codex__codex | commands/claude-delegator/task.md |
| cmd:delegator-uninstall | /claude-delegator/uninstall | (cleanup actions) | commands/claude-delegator/uninstall.md |

---

## Skills (18 total)

| ID | Label | Directory | Trigger Pattern |
|----|-------|-----------|-----------------|
| skill:planning-with-files | PlanningWithFiles | skills/PlanningWithFiles | complex tasks, multi-step projects |
| skill:brainstorming | Brainstorming | skills/Brainstorming | generate options, constraints, risks |
| skill:writing-plans | WritingPlans | skills/WritingPlans | produce verifiable task plan |
| skill:executing-plans | ExecutingPlans | skills/ExecutingPlans | iterate tasks, keep plan in sync |
| skill:test-driven-development | TestDrivenDevelopment | skills/TestDrivenDevelopment | RED/GREEN/REFACTOR cycle |
| skill:systematic-debugging | SystematicDebugging | skills/SystematicDebugging | exceptions, failing commands, CI errors |
| skill:verification-before-completion | VerificationBeforeCompletion | skills/VerificationBeforeCompletion | run checks before delivery |
| skill:subagent-driven-development | SubagentDrivenDevelopment | skills/SubagentDrivenDevelopment | break into parallelizable chunks |
| skill:dispatching-parallel-agents | DispatchingParallelAgents | skills/DispatchingParallelAgents | parallel agent dispatch |
| skill:requesting-code-review | RequestingCodeReview | skills/RequestingCodeReview | prepare review summary |
| skill:receiving-code-review | ReceivingCodeReview | skills/ReceivingCodeReview | process reviewer feedback |
| skill:finishing-a-development-branch | FinishingDevelopmentBranch | skills/FinishingDevelopmentBranch | finalize branch safely |
| skill:using-git-worktrees | UsingGitWorktrees | skills/UsingGitWorktrees | parallel work via worktrees |
| skill:using-workflows | UsingWorkflows | skills/UsingWorkflows | check/invoke workflow skills |
| skill:writing-skills | WritingSkills | skills/WritingSkills | author/update skills |
| skill:react-useeffect | ReactUseEffect | skills/ReactUseEffect | React useEffect best practices |
| skill:compound | Compound | skills/Compound | capture solved problems |
| skill:review | Review | skills/Review | focused code review |

### Skill Activation Mechanism

Skills are activated via **implicit context matching** by the model based on:
1. `USE WHEN` clause in SKILL.md description
2. Keywords in user prompt
3. Context from previous tool calls

**Note:** No code enforces skill activation - it's purely model discretion (GAP-013).

---

## Agents (19 total)

### General Purpose Agents (5)

| ID | Label | Model | Purpose |
|----|-------|-------|---------|
| agent:codebase-search | codebase-search | haiku | Find patterns in codebase |
| agent:open-source-librarian | open-source-librarian | sonnet | External docs, OSS examples |
| agent:oracle | oracle | opus | Architecture, debugging |
| agent:tech-docs-writer | tech-docs-writer | sonnet | README, API docs |
| agent:media-interpreter | media-interpreter | sonnet | Image/media analysis |

### Review Agents (14)

| ID | Label | Model | Trigger Condition |
|----|-------|-------|-------------------|
| agent:review-security-sentinel | security-sentinel | haiku | >3 files OR risky areas |
| agent:review-architecture-strategist | architecture-strategist | sonnet | >3 files OR risky areas |
| agent:review-typescript | typescript | haiku | .ts/.tsx files |
| agent:review-python | python | haiku | .py files |
| agent:review-rails | rails | haiku | .rb files OR Gemfile |
| agent:review-dhh-rails | dhh-rails | sonnet | Conventional Rails |
| agent:review-data-migration-expert | data-migration-expert | sonnet | DB migrations |
| agent:review-data-integrity-guardian | data-integrity-guardian | sonnet | DB migrations |
| agent:review-deployment-verification | deployment-verification | sonnet | Config/deploy files |
| agent:review-frontend-races | frontend-races | sonnet | Frontend async/state |
| agent:review-performance-oracle | performance-oracle | sonnet | Perf-sensitive paths |
| agent:review-agent-native | agent-native | sonnet | Agent/prompt files |
| agent:review-code-simplicity | code-simplicity | haiku | Complex logic |
| agent:review-pattern-recognition | pattern-recognition | sonnet | Pattern violations |

---

## Codex Experts (5)

| ID | Label | Mode | Purpose |
|----|-------|------|---------|
| expert:architect | architect | advisory | Architecture, tradeoffs |
| expert:plan-reviewer | plan-reviewer | advisory | Review plans |
| expert:scope-analyst | scope-analyst | advisory | Ambiguous scope |
| expert:code-reviewer | code-reviewer | advisory | Code review |
| expert:security-analyst | security-analyst | advisory | Security review |

---

## Rules (8)

| ID | Label | Scope | Evidence |
|----|-------|-------|----------|
| rule:typescript | typescript.md | **/*.{ts,tsx} | rules/typescript.md |
| rule:testing | testing.md | **/*.{test,spec}.ts | rules/testing.md |
| rule:comments | comments.md | all | rules/comments.md |
| rule:forge | forge.md | **/*.sol | rules/forge.md |
| rule:delegator-orchestration | delegator/orchestration.md | delegation | rules/delegator/orchestration.md |
| rule:delegator-triggers | delegator/triggers.md | delegation | rules/delegator/triggers.md |
| rule:delegator-model-selection | delegator/model-selection.md | delegation | rules/delegator/model-selection.md |
| rule:delegator-delegation-format | delegator/delegation-format.md | delegation | rules/delegator/delegation-format.md |

---

## Verified Invariants

### INV-001: No Bypass
**Statement:** No capability/tool execution path skips required routing + required lifecycle stages.
**Status:** PARTIALLY VERIFIED
**Evidence:**
- All slash commands go through Claude Code routing
- PostToolUse hooks fire on Write/Edit
- Stop hooks fire on session end
**Gaps:** keyword-detector suggestions can be ignored (GAP-001)

### INV-002: Lifecycle Reliability
**Statement:** Required lifecycle stages fire on success, error, stop/abort, and teardown.
**Status:** PARTIALLY VERIFIED
**Evidence:**
- Stop hooks have safety valve (10 blocks max)
- Hooks are non-blocking by default (except Stop)
**Gaps:** Hook ordering undefined (GAP-019)

### INV-003: Canonical Routing
**Statement:** One explicit decision point selects module/capability invocation.
**Status:** VERIFIED
**Evidence:**
- Slash commands route to specific command handlers
- Review command uses explicit routing table

### INV-004: Deterministic Boundaries
**Statement:** Policy/validation is deterministic; LLM only at explicit gates.
**Status:** PARTIALLY VERIFIED
**Evidence:**
- Hooks are code-based (deterministic)
- Skill activation is model-discretionary (non-deterministic)
**Gaps:** Skill activation not enforced (GAP-013)

### INV-005: Auditability
**Statement:** Every routed action produces traceable artifacts.
**Status:** PARTIALLY VERIFIED
**Evidence:**
- Transcript captures all tool calls
- Debug logs capture hook invocations
**Gaps:** Unbounded logging (GAP-006, GAP-018)

### INV-006: Testability
**Statement:** Each invariant has at least one automated test.
**Status:** NOT VERIFIED
**Evidence:** Only structure_test.sh and schema_test.py exist
**Gaps:** No invariant tests (see test-plan.md)

---

## Configuration

### settings.json Structure

```json
{
  "hooks": {
    "UserPromptSubmit": [{ "hooks": [{"type": "command", "command": "..."}] }],
    "PostToolUse": [{ "matcher": "Write|Edit", "hooks": [...] }],
    "Stop": [{ "hooks": [...] }, { "hooks": [...] }]
  }
}
```

### Key Paths

| Path | Purpose |
|------|---------|
| `~/.claude/settings.json` | Global settings |
| `~/.claude/settings.local.json` | Local overrides |
| `~/.claude/hooks/` | Hook logs |
| `~/.claude/prompts/delegator/` | Expert prompts |
| `.claude/.state/` | Repo-local state (test cache) |

---

## Count Summary

| Component | Count |
|-----------|-------|
| Entry Points | 4 |
| Hooks | 4 |
| Commands | 9 |
| Skills | 18 |
| Agents | 19 |
| Experts | 5 |
| Rules | 8 |
| Context Modes | 5 |
| **Total Nodes** | **72** |
| **Total Edges** | **47** |
