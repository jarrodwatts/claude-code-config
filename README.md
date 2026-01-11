# Claude Code Config

my personal claude code configuration - mostly not created by me, but sourced from many talented people in the community.

## Installation

### Option 1: Install Script (Recommended)

```bash
git clone https://github.com/Esk3nder/claude-code-config.git /tmp/claude-config
cd /tmp/claude-config
./install.sh
```

The script will:
- Check dependencies (jq, python3)
- Copy all components to `~/.claude/`
- Merge hook wiring into `settings.json`
- Make hooks executable

Use `./install.sh --force` to overwrite without prompting.

### Option 2: Copy-Paste into Claude Code (No Git Required)

Copy the prompt from [INSTALL.md](INSTALL.md) and paste it into Claude Code. Claude will fetch and install all config files automatically.

### Option 3: Git Clone (Direct)

```bash
git clone https://github.com/Esk3nder/claude-code-config.git ~/.claude
cp ~/.claude/settings.json.example ~/.claude/settings.json
```

### Option 4: Selective Install

```bash
# Clone elsewhere first
git clone https://github.com/Esk3nder/claude-code-config.git /tmp/claude-config

# Copy what you need
cp -r /tmp/claude-config/rules/* ~/.claude/rules/
cp -r /tmp/claude-config/skills/* ~/.claude/skills/
cp -r /tmp/claude-config/agents/* ~/.claude/agents/
```

## Contents

### Rules (`.claude/rules/`)

Path-scoped instructions loaded automatically when working with matching files.

| File | Scope | Description |
|------|-------|-------------|
| `typescript.md` | `**/*.{ts,tsx}` | TypeScript conventions |
| `testing.md` | `**/*.{test,spec}.ts` | Testing patterns |
| `comments.md` | All files | Comment policy |
| `forge.md` | `**/*.sol` | Foundry/ZKsync rules |

### Skills (`.claude/skills/`)

Model-invoked capabilities Claude applies automatically.

| Skill | Description |
|-------|-------------|
| `planning-with-files` | Manus-style persistent markdown planning |
| `react-useeffect` | React useEffect guardrails |
| `using-workflows` | Enforce checking relevant skills before acting |
| `brainstorming` | Generate options/risks before committing |
| `writing-plans` | Write short verifiable plans to plans/{slug}.md |
| `executing-plans` | Default plan executor with status updates |
| `subagent-driven-development` | Delegate large parallelizable plans |
| `dispatching-parallel-agents` | Launch parallel agents when explicitly requested |
| `test-driven-development` | Red→Green→Refactor workflow |
| `verification-before-completion` | Run required checks before finishing |
| `systematic-debugging` | Reproduce and localize failures methodically |
| `requesting-code-review` | Prepare concise review handoff |
| `receiving-code-review` | Process reviewer feedback systematically |
| `finishing-a-development-branch` | Clean, verify, and hand off a branch |
| `using-git-worktrees` | Safe parallel branch/worktree habits |
| `writing-skills` | Guidance for authoring new skills |

### Agents (`.claude/agents/`)

Custom subagents for specialized tasks.

| Agent | Description |
|-------|-------------|
| `codebase-search` | Find files and implementations |
| `media-interpreter` | Extract info from PDFs/images |
| `open-source-librarian` | Research OSS with citations |
| `tech-docs-writer` | Create technical documentation |
| `review/*` | Specialized review agents (see `agents/review/index.md`) |

### Commands (`.claude/commands/`)

Custom slash commands.

| Command | Description |
|---------|-------------|
| `interview` | Interactive planning/spec fleshing |
| `workflows/brainstorm` | Run the Workflows brainstorming loop |
| `workflows/plan` | Create/update `plans/{slug}.md` with short verifiable tasks |
| `workflows/work` | Walk plan tasks, update status, run checks |
| `workflows/review` | Multi-agent code review with TodoWrite findings |
| `workflows/compound` | Capture solved problems in `docs/solutions/` |

### Hooks (`.claude/hooks/`)

Scripts triggered by Claude Code events.

| Hook | Event | Description |
|------|-------|-------------|
| `keyword-detector.py` | UserPromptSubmit | Detects keywords in prompts |
| `check-comments.py` | PostToolUse (Write/Edit) | Validates comment policy |
| `todo-enforcer.sh` | Stop | Ensures todos are tracked |
| `workflows/require-green-tests.sh` | Stop | Blocks finish unless tests are green (with caching) |

### CLAUDE.md

Personal global instructions loaded into every session.

## Recommended Plugins

Plugins I use alongside this config. Install via CLI:

### Official Plugins

```bash
claude plugin install frontend-design
claude plugin install code-review
claude plugin install typescript-lsp
claude plugin install plugin-dev
claude plugin install ralph-loop
```

### claude-hud (status line)

Add the marketplace first, then install:

```bash
claude plugin marketplace add jarrodwatts/claude-hud
claude plugin install claude-hud@claude-hud
```
