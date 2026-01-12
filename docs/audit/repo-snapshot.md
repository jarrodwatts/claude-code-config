# Repo Snapshot

**Generated**: 2026-01-11
**Repository**: claude-code-config (philadelphia)
**Branch**: Esk3nder/audit-routing-claims

## Repository Structure

```
claude-code-config/
├── CLAUDE.md                 # Global instructions (project root)
├── README.md                 # Project documentation (702 lines)
├── INSTALL.md                # Installation guide (163 lines)
├── install.sh                # Installer (copies config to ~/.claude/)
├── settings.json.example     # Hook wiring template
├── agents/                   # Custom subagents (19 agent defs + index)
│   ├── codebase-search.md
│   ├── media-interpreter.md
│   ├── open-source-librarian.md
│   ├── oracle.md
│   ├── tech-docs-writer.md
│   └── review/               # Review specialist agents (14 files + index)
│       ├── index.md
│       ├── agent-native.md
│       ├── architecture-strategist.md
│       ├── code-simplicity.md
│       ├── data-integrity-guardian.md
│       ├── data-migration-expert.md
│       ├── deployment-verification.md
│       ├── dhh-rails.md
│       ├── frontend-races.md
│       ├── pattern-recognition.md
│       ├── performance-oracle.md
│       ├── python.md
│       ├── rails.md
│       ├── security-sentinel.md
│       └── typescript.md
├── commands/                 # Slash commands (9 files)
│   ├── interview.md
│   ├── workflows/
│   │   ├── brainstorm.md
│   │   ├── plan.md
│   │   ├── work.md
│   │   ├── review.md
│   │   └── compound.md
│   └── claude-delegator/
│       ├── setup.md
│       ├── task.md
│       └── uninstall.md
├── config/                   # Configuration files (3 files)
│   └── delegator/
│       ├── mcp-servers.example.json
│       ├── providers.json
│       └── experts.json
├── hooks/                    # Event-triggered scripts (4 files)
│   ├── keyword-detector.py   # UserPromptSubmit hook
│   ├── check-comments.py     # PostToolUse hook (Write|Edit)
│   ├── todo-enforcer.sh      # Stop hook
│   └── workflows/
│       └── require-green-tests.sh  # Stop hook
├── prompts/                  # Codex expert prompts (5 files)
│   └── delegator/
│       ├── architect.md
│       ├── plan-reviewer.md
│       ├── scope-analyst.md
│       ├── code-reviewer.md
│       └── security-analyst.md
├── rules/                    # Path-scoped rules (8 files)
│   ├── typescript.md
│   ├── testing.md
│   ├── comments.md
│   ├── forge.md
│   └── delegator/
│       ├── orchestration.md
│       ├── triggers.md
│       ├── model-selection.md
│       └── delegation-format.md
├── tests/                    # Repo validation checks
│   ├── schema_test.py
│   └── structure_test.sh
└── skills/                   # Model-invoked capabilities (16 directories)
    ├── planning-with-files/
    ├── react-useeffect/
    ├── using-workflows/
    ├── brainstorming/
    ├── writing-plans/
    ├── executing-plans/
    ├── subagent-driven-development/
    ├── dispatching-parallel-agents/
    ├── test-driven-development/
    ├── verification-before-completion/
    ├── systematic-debugging/
    ├── requesting-code-review/
    ├── receiving-code-review/
    ├── finishing-a-development-branch/
    ├── using-git-worktrees/
    └── writing-skills/
```

## Component Inventory

| Component | Count | Location |
|-----------|-------|----------|
| Skills | 16 | `skills/*/SKILL.md` |
| Agents | 19 | `agents/*.md`, `agents/review/*.md` |
| Hooks | 4 | `hooks/*.py`, `hooks/*.sh`, `hooks/workflows/*.sh` |
| Rules | 8 | `rules/*.md`, `rules/delegator/*.md` |
| Commands | 9 | `commands/*.md`, `commands/workflows/*.md`, `commands/claude-delegator/*.md` |
| Prompts | 5 | `prompts/delegator/*.md` |
| Config | 3 | `config/delegator/*.json` |

## Entrypoints

### User-Invocable

| Entrypoint | Type | Trigger |
|------------|------|---------|
| `/interview` | Command | User types `/interview` |
| `/workflows/brainstorm` | Command | User types `/workflows/brainstorm` |
| `/workflows/plan` | Command | User types `/workflows/plan` |
| `/workflows/work` | Command | User types `/workflows/work` |
| `/workflows/review` | Command | User types `/workflows/review` |
| `/workflows/compound` | Command | User types `/workflows/compound` |
| `/claude-delegator/setup` | Command | User types `/claude-delegator/setup` |
| `/claude-delegator/task` | Command | User types `/claude-delegator/task` |
| `/claude-delegator/uninstall` | Command | User types `/claude-delegator/uninstall` |

### Model-Invocable (Skills)

Skills are auto-activated by Claude Code based on context matching in `SKILL.md` files. No explicit user trigger required.

### Event-Triggered (Hooks)

| Hook | Event | Condition |
|------|-------|-----------|
| `keyword-detector.py` | UserPromptSubmit | Always fires |
| `check-comments.py` | PostToolUse | Matcher: `Write\|Edit` |
| `require-green-tests.sh` | Stop | Always fires |
| `todo-enforcer.sh` | Stop | Always fires |

## Installation Method

### Documented Methods

1. **Quick Install** (README/INSTALL.md line 5-8):
   ```bash
   git clone https://github.com/Esk3nder/claude-code-config.git /tmp/claude-config
   cd /tmp/claude-config && ./install.sh
   ```
   **STATUS: WORKING** - `install.sh` exists and installs config into `~/.claude/` (including hook wiring via `settings.json.example`).

2. **Manual Install via Claude Code** (INSTALL.md line 14-141):
   - Copy prompt into Claude Code
   - Claude fetches files via curl and installs to `~/.claude/`
   - Requires manual merge of hook wiring into `~/.claude/settings.json`

### Runtime Contract

- Files must be installed to `~/.claude/` directory
- Hook scripts require executable permission (`chmod +x`)
- Hook wiring requires `settings.json` configuration (manual merge for manual install; `install.sh` can merge via `settings.json.example`)
- Dependencies: `jq` (todo-enforcer.sh), `python3` (keyword-detector.py, check-comments.py)

## Verification Commands

| Check | Command | Notes |
|-------|---------|-------|
| Hook executability | `ls -la hooks/*.py hooks/*.sh hooks/workflows/*.sh` | Should show `rwxr-xr-x` |
| Python syntax | `python3 -m py_compile hooks/*.py` | Exit 0 = valid |
| Shell syntax | `bash -n hooks/*.sh hooks/workflows/*.sh` | Exit 0 = valid |
| JSON validity | `jq . config/delegator/*.json` | Exit 0 = valid |
| File existence | `find skills -name "SKILL.md"` | Should find 16 files |
| Repo structure | `bash tests/structure_test.sh` | Verifies required files + counts |
| Repo schema | `python3 tests/schema_test.py` | Validates frontmatter + JSON |

## Evidence

- Component counts verified by `find` and `ls` commands
- File structure verified by `tree` equivalent (recursive glob)
- All paths confirmed to exist in repository
