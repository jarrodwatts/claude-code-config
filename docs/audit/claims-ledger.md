# Claims Ledger

**Generated**: 2026-01-12

## Summary

| Outcome | Count |
|---------|-------|
| TRUE | 29 |
| PARTIAL | 2 |
| FALSE | 0 |
| UNVERIFIABLE | 0 |

## Component Count Claims

### Claim 1: "Skills (16)"
- **Source**: README.md, INSTALL.md table
- **Outcome**: TRUE
- **Evidence**: `find skills -name "SKILL.md" | wc -l` returns 16
- **Files**:
  - skills/planning-with-files/SKILL.md
  - skills/react-useeffect/SKILL.md
  - skills/using-workflows/SKILL.md
  - skills/brainstorming/SKILL.md
  - skills/writing-plans/SKILL.md
  - skills/executing-plans/SKILL.md
  - skills/subagent-driven-development/SKILL.md
  - skills/dispatching-parallel-agents/SKILL.md
  - skills/test-driven-development/SKILL.md
  - skills/verification-before-completion/SKILL.md
  - skills/systematic-debugging/SKILL.md
  - skills/requesting-code-review/SKILL.md
  - skills/receiving-code-review/SKILL.md
  - skills/finishing-a-development-branch/SKILL.md
  - skills/using-git-worktrees/SKILL.md
  - skills/writing-skills/SKILL.md

### Claim 2: "Agents (19)" / "5 + 14 review specialists"
- **Source**: README.md, INSTALL.md table
- **Outcome**: TRUE
- **Evidence**: 5 root agents + 14 review agents = 19 (excluding `agents/review/index.md`, which is a non-agent index file)
- **Files**:
  - agents/codebase-search.md
  - agents/media-interpreter.md
  - agents/open-source-librarian.md
  - agents/oracle.md
  - agents/tech-docs-writer.md
  - agents/review/agent-native.md
  - agents/review/architecture-strategist.md
  - agents/review/code-simplicity.md
  - agents/review/data-integrity-guardian.md
  - agents/review/data-migration-expert.md
  - agents/review/deployment-verification.md
  - agents/review/dhh-rails.md
  - agents/review/frontend-races.md
  - agents/review/pattern-recognition.md
  - agents/review/performance-oracle.md
  - agents/review/python.md
  - agents/review/rails.md
  - agents/review/security-sentinel.md
  - agents/review/typescript.md

### Claim 3: "Hooks (4)"
- **Source**: README.md, INSTALL.md table
- **Outcome**: TRUE
- **Evidence**: 4 hook scripts exist
- **Files**:
  - hooks/keyword-detector.py
  - hooks/check-comments.py
  - hooks/todo-enforcer.sh
  - hooks/workflows/require-green-tests.sh

### Claim 4: "Rules (8)"
- **Source**: README.md, INSTALL.md table
- **Outcome**: TRUE
- **Evidence**: 4 root + 4 delegator rules = 8
- **Files**:
  - rules/typescript.md
  - rules/testing.md
  - rules/comments.md
  - rules/forge.md
  - rules/delegator/orchestration.md
  - rules/delegator/triggers.md
  - rules/delegator/model-selection.md
  - rules/delegator/delegation-format.md

### Claim 5: "Commands (9)"
- **Source**: README.md, INSTALL.md table
- **Outcome**: TRUE
- **Evidence**: 1 root + 5 workflows + 3 delegator = 9
- **Files**:
  - commands/interview.md
  - commands/workflows/brainstorm.md
  - commands/workflows/plan.md
  - commands/workflows/work.md
  - commands/workflows/review.md
  - commands/workflows/compound.md
  - commands/claude-delegator/setup.md
  - commands/claude-delegator/task.md
  - commands/claude-delegator/uninstall.md

### Claim 6: "Prompts (5)"
- **Source**: README.md, INSTALL.md table
- **Outcome**: TRUE
- **Evidence**: 5 prompts in delegator directory
- **Files**:
  - prompts/delegator/architect.md
  - prompts/delegator/plan-reviewer.md
  - prompts/delegator/scope-analyst.md
  - prompts/delegator/code-reviewer.md
  - prompts/delegator/security-analyst.md

### Claim 7: "Config (3)"
- **Source**: INSTALL.md table
- **Outcome**: TRUE
- **Evidence**: 3 JSON files
- **Files**:
  - config/delegator/mcp-servers.example.json
  - config/delegator/providers.json
  - config/delegator/experts.json

## Installation Claims

### Claim 8: "Quick Install" via install.sh
- **Source**: README.md line 5-8, INSTALL.md line 5-8
- **Outcome**: TRUE
- **Evidence**: `install.sh` exists and installs repo contents into `~/.claude/`, makes hooks executable, and merges hook wiring from `settings.json.example`

### Claim 9: "Manual Install via Claude Code"
- **Source**: INSTALL.md line 14-141
- **Outcome**: TRUE
- **Evidence**: All URLs in manual install section point to files that exist in repository
- **Verification**: Each raw.githubusercontent.com URL corresponds to existing file path

### Claim 10: "Hook wiring in settings.json"
- **Source**: INSTALL.md lines 105-122
- **Outcome**: TRUE
- **Evidence**: JSON snippet is syntactically valid; hook paths match actual files
- **Note**: Requires manual merge by user; not automated

## Feature Claims

### Claim 11: "Keyword detection injects guidance"
- **Source**: README.md
- **Outcome**: TRUE
- **Evidence**: hooks/keyword-detector.py:60-130 implements keyword detection and outputs JSON guidance
- **Keywords**: ultrawork, delegate, search, analyze, think

### Claim 12: "Comment ratio validation"
- **Source**: README.md
- **Outcome**: TRUE
- **Evidence**: hooks/check-comments.py calculates comment ratio and emits a warning via `hookSpecificOutput.additionalContext` when comment ratio exceeds 25% (does not block tool execution)

### Claim 13: "Test enforcement before completion"
- **Source**: README.md, skills/verification-before-completion
- **Outcome**: TRUE
- **Evidence**: hooks/workflows/require-green-tests.sh implements Stop hook that runs tests

### Claim 14: "Todo enforcement before completion"
- **Source**: README.md
- **Outcome**: TRUE
- **Evidence**: hooks/todo-enforcer.sh:80-120 checks for incomplete todos

### Claim 15: "Safety valve after 10 blocks"
- **Source**: hooks/todo-enforcer.sh:18
- **Outcome**: TRUE
- **Evidence**: `MAX_CONSECUTIVE_BLOCKS=10` and the safety valve allows exit after 10 consecutive blocks

### Claim 16: "Auto-detects test framework"
- **Source**: README.md
- **Outcome**: TRUE
- **Evidence**: hooks/workflows/require-green-tests.sh:20-45 detects pnpm/yarn/npm via lockfile

### Claim 17: "WORKFLOWS_TEST_CMD override"
- **Source**: INSTALL.md line 123
- **Outcome**: TRUE
- **Evidence**: hooks/workflows/require-green-tests.sh:10-15 checks WORKFLOWS_TEST_CMD env var

### Claim 18: "Legacy SUPERPOWERS_TEST_CMD support"
- **Source**: INSTALL.md line 123
- **Outcome**: TRUE
- **Evidence**: hooks/workflows/require-green-tests.sh also checks SUPERPOWERS_TEST_CMD

### Claim 19: "Test result caching"
- **Source**: README.md
- **Outcome**: TRUE
- **Evidence**: hooks/workflows/require-green-tests.sh:50-70 implements cache in .claude/.state/last_tests.env

### Claim 20: "Skills auto-activate based on context"
- **Source**: README.md
- **Outcome**: PARTIAL
- **Evidence**: Skills have SKILL.md files with activation criteria, but activation is implicit via Claude Code model context matching - no explicit trigger verification possible
- **Note**: Depends on Claude Code runtime behavior, not repo code

## Delegator Claims

### Claim 21: "Codex expert delegation via /claude-delegator/task"
- **Source**: README.md, commands/claude-delegator/task.md
- **Outcome**: TRUE
- **Evidence**: Command file exists, references config/delegator/experts.json mapping

### Claim 22: "5 expert personas"
- **Source**: README.md
- **Outcome**: TRUE
- **Evidence**: config/delegator/experts.json defines 5 experts: architect, plan-reviewer, scope-analyst, code-reviewer, security-analyst

### Claim 23: "Expert-to-agent mapping"
- **Source**: config/delegator/experts.json
- **Outcome**: TRUE
- **Evidence**: JSON maps each expert to `prompt`, `nativeAgent`, and `skills` fields

### Claim 24: "MCP server configuration"
- **Source**: README.md, config/delegator/mcp-servers.example.json
- **Outcome**: PARTIAL
- **Evidence**: Example config exists but requires user setup; not auto-configured
- **Note**: User must manually configure MCP connection

## Workflow Claims

### Claim 25: "Brainstorm → Plan → Work → Review cycle"
- **Source**: README.md
- **Outcome**: TRUE
- **Evidence**: All 4 workflow commands exist in commands/workflows/

### Claim 26: "Compound workflow combines phases"
- **Source**: README.md, commands/workflows/compound.md
- **Outcome**: TRUE
- **Evidence**: compound.md file exists and describes multi-phase workflow

### Claim 27: "Plan-based development with plans/*.md"
- **Source**: skills/planning-with-files, skills/writing-plans
- **Outcome**: TRUE
- **Evidence**: Skills reference plans/ directory convention

### Claim 28: "Git worktree support"
- **Source**: README.md, skills/using-git-worktrees
- **Outcome**: TRUE
- **Evidence**: skills/using-git-worktrees/SKILL.md exists

### Claim 29: "TDD workflow"
- **Source**: README.md, skills/test-driven-development
- **Outcome**: TRUE
- **Evidence**: skills/test-driven-development/SKILL.md exists

### Claim 30: "Systematic debugging"
- **Source**: README.md, skills/systematic-debugging
- **Outcome**: TRUE
- **Evidence**: skills/systematic-debugging/SKILL.md exists

### Claim 31: "Code review request/receive workflows"
- **Source**: README.md
- **Outcome**: TRUE
- **Evidence**: Both skills/requesting-code-review and skills/receiving-code-review exist

## Evidence Summary

| Category | TRUE | PARTIAL | FALSE |
|----------|------|---------|-------|
| Component Counts | 7 | 0 | 0 |
| Installation | 3 | 0 | 0 |
| Features | 10 | 0 | 0 |
| Delegator | 3 | 1 | 0 |
| Workflows | 6 | 1 | 0 |
| **Total** | **29** | **2** | **0** |
