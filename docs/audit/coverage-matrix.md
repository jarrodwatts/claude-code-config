# Coverage Matrix

**Last Updated:** 2026-01-12 (Pass 2)

## Overview

This matrix maps all triggers to their routes, modules, lifecycle stages, and test coverage status.

---

## Command → Tool Allowlists

Each command restricts which tools can be used during execution.

| Command | Allowed Tools | Purpose |
|---------|--------------|---------|
| `/interview` | AskUserQuestion, Read, Glob, Grep, Write, Edit | Interactive spec clarification |
| `/workflows/brainstorm` | AskUserQuestion, Read, Glob, Grep | Generate options (read-only + questions) |
| `/workflows/plan` | Read, Glob, Grep, Write, Edit | Create/update plan files |
| `/workflows/work` | Read, Glob, Grep, Write, Edit, Bash | Execute plan tasks |
| `/workflows/resume` | Read, Glob, Grep, Write, Edit, Bash | Continue interrupted plan |
| `/workflows/review` | Read, Glob, Grep, Bash, TodoWrite, Task | Multi-agent code review |
| `/workflows/compound` | Read, Glob, Grep, Write, Edit | Document solutions |
| `/claude-delegator/setup` | Bash, Read, Write, Edit, AskUserQuestion | Configure Codex MCP |
| `/claude-delegator/task` | Read, AskUserQuestion, Bash, mcp__codex__codex | Delegate to Codex expert |
| `/claude-delegator/uninstall` | Bash, Read, Write, Edit, AskUserQuestion | Remove delegator config |

---

## Trigger → Route → Module Matrix

### User Prompt Triggers

| Trigger | Route | Module(s) | Lifecycle Hooks | Tests |
|---------|-------|-----------|-----------------|-------|
| Any user prompt | entry:user-prompt | hook:keyword-detector | UserPromptSubmit | None |
| Contains "ultrawork" | hook:keyword-detector | context:ultrawork-mode | Context injection | None |
| Contains "delegate/parallel" | hook:keyword-detector | context:delegation-mode | Context injection | None |
| Contains "search/find" | hook:keyword-detector | context:search-mode | Context injection | None |
| Contains "analyze/debug" | hook:keyword-detector | context:analysis-mode | Context injection | None |
| Contains "think deeply" | hook:keyword-detector | context:think-mode | Context injection | None |

### Slash Command Triggers

| Trigger | Route | Module(s) | Lifecycle Hooks | Tests |
|---------|-------|-----------|-----------------|-------|
| /interview | cmd:interview | (direct execution) | None | None |
| /workflows/brainstorm | cmd:workflows-brainstorm | skill:brainstorming | None | None |
| /workflows/plan | cmd:workflows-plan | skill:writing-plans | None | None |
| /workflows/work | cmd:workflows-work | skill:executing-plans | None | None |
| /workflows/review | cmd:workflows-review | skill:review, agents:review-* | None | None |
| /workflows/compound | cmd:workflows-compound | skill:compound | None | None |
| /claude-delegator/setup | cmd:delegator-setup | (setup) | None | None |
| /claude-delegator/task | cmd:delegator-task | expert:* | None | None |
| /claude-delegator/uninstall | cmd:delegator-uninstall | (cleanup) | None | None |

### Tool Use Triggers

| Trigger | Route | Module(s) | Lifecycle Hooks | Tests |
|---------|-------|-----------|-----------------|-------|
| Write tool call | entry:tool-use | hook:check-comments | PostToolUse | None |
| Edit tool call | entry:tool-use | hook:check-comments | PostToolUse | None |
| Other tool calls | entry:tool-use | (none) | None | N/A |

### Session Triggers

| Trigger | Route | Module(s) | Lifecycle Hooks | Tests |
|---------|-------|-----------|-----------------|-------|
| User exits | entry:session-stop | hook:require-green-tests, hook:todo-enforcer | Stop | None |
| Task completes | entry:session-stop | hook:require-green-tests, hook:todo-enforcer | Stop | None |

---

## Review Agent Dispatch Matrix

| Changed Files | Agents Dispatched | Condition |
|---------------|-------------------|-----------|
| >3 files OR risky areas | security-sentinel, architecture-strategist | Always |
| .ts, .tsx | typescript | File type match |
| .py | python | File type match |
| .rb OR Gemfile | rails | File type match |
| .rb + conventional | rails, dhh-rails | File type + convention |
| DB migrations | data-migration-expert, data-integrity-guardian | File path match |
| config/deploy | deployment-verification | File path match |
| Frontend async/state | frontend-races | Content analysis |
| Perf-sensitive paths | performance-oracle | Path match |
| agent/prompt files | agent-native | File path match |
| Complex logic | code-simplicity | Content analysis |
| Pattern violations | pattern-recognition | Content analysis |

---

## Lifecycle Stage Coverage

### UserPromptSubmit Stage

| Hook | Blocking | Fires On | Coverage |
|------|----------|----------|----------|
| keyword-detector.py | No | All prompts | COVERED |

### PostToolUse Stage

| Hook | Blocking | Fires On | Coverage |
|------|----------|----------|----------|
| check-comments.py | No | Write\|Edit | COVERED |

### Stop Stage

| Hook | Blocking | Fires On | Coverage |
|------|----------|----------|----------|
| require-green-tests.sh | Yes | Session stop | COVERED |
| todo-enforcer.sh | Yes | Session stop | COVERED |

### Missing Lifecycle Stages

| Stage | Hooks | Status |
|-------|-------|--------|
| PreToolUse | None | GAP-012: Could auto-dispatch agents |
| Error | None | Not implemented |
| Abort | None | Not implemented |

---

## Tool Categories

| Category | Tools | When Available |
|----------|-------|----------------|
| **Read-only** | Read, Glob, Grep | All commands |
| **Write** | Write, Edit | Plan/work/compound only |
| **Execute** | Bash | Work/review/delegator |
| **Interact** | AskUserQuestion | Brainstorm/interview/delegator |
| **Orchestrate** | Task, TodoWrite | Review only |
| **External** | mcp__codex__codex | Delegator task only |

---

## Test Coverage Summary

### Existing Tests

| Test File | Covers | Status |
|-----------|--------|--------|
| tests/structure_test.sh | File structure validation | Passing |
| tests/schema_test.py | JSON schema validation | Passing |

### Missing Tests

| Gap ID | Test Needed | Priority |
|--------|-------------|----------|
| GAP-001 | keyword-detector context injection test | P1 |
| GAP-004 | TOCTOU race condition test | P1 |
| GAP-009 | jq dependency failure test | P1 |
| GAP-006 | Log file size limit test | P2 |
| GAP-019 | Hook ordering test | P2 |
| GAP-020 | Codex 7-section validation test | P2 |

---

## Routing Path Coverage

### Fully Covered Paths

| Path | Entry → Exit | Verified |
|------|--------------|----------|
| User prompt → keyword-detector → context injection | Yes | Pass 2 |
| /workflows/brainstorm → skill:brainstorming | Yes | Pass 2 |
| /workflows/plan → skill:writing-plans | Yes | Pass 2 |
| /workflows/work → skill:executing-plans | Yes | Pass 2 |
| /workflows/review → agents + skill | Yes | Pass 2 |
| /workflows/compound → skill:compound | Yes | Pass 2 |
| Write tool → check-comments | Yes | Pass 2 |
| Session stop → require-green-tests | Yes | Pass 2 |
| Session stop → todo-enforcer | Yes | Pass 2 |

### Partially Covered Paths

| Path | Issue | Gap ID |
|------|-------|--------|
| keyword-detector → agent dispatch | Suggestions only, no enforcement | GAP-001 |
| /claude-delegator/task → expert selection | No 7-section validation | GAP-020 |

### Uncovered Paths

| Path | Status | Gap ID |
|------|--------|--------|
| /workflows/resume | Command exists but not in graph | GAP-016 |
| PreToolUse → agent auto-dispatch | Not implemented | GAP-012 |

---

## Invariant Verification Matrix

| Invariant | Paths Tested | Coverage | Status |
|-----------|--------------|----------|--------|
| INV-001: No Bypass | All slash commands | 9/9 | PARTIAL (GAP-001) |
| INV-002: Lifecycle Reliability | Stop hooks | 2/2 | PARTIAL (GAP-019) |
| INV-003: Canonical Routing | Review routing table | 14/14 | VERIFIED |
| INV-004: Deterministic Boundaries | Hooks only | 4/4 | PARTIAL (GAP-013) |
| INV-005: Auditability | Logs | N/A | PARTIAL (GAP-006) |
| INV-006: Testability | Test files | 2/? | NOT VERIFIED |

---

## Policy Notes

1. **Brainstorm is read-only** — no file modifications during ideation
2. **Review can spawn agents** — Task tool enabled for parallel dispatch
3. **Delegator task has MCP access** — can call external Codex CLI
4. **Resume mirrors work** — same capabilities for continuation

---

## Legend

- **Trigger**: The event that initiates routing
- **Route**: The path taken through the system
- **Module**: The capability invoked
- **Lifecycle Hooks**: Hooks that fire during this path
- **Tests**: Automated tests covering this path
- **COVERED**: Path has been verified to exist
- **PARTIAL**: Path exists but has known gaps
- **NOT VERIFIED**: No verification performed
