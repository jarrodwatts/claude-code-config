# Claude Code Config

A curated collection of skills, agents, rules, hooks, and workflows for Claude Code—transforming it from a coding assistant into a structured software development environment.

![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
![Skills](https://img.shields.io/badge/Skills-16-green)
![Agents](https://img.shields.io/badge/Agents-19-orange)
![Hooks](https://img.shields.io/badge/Hooks-4-purple)
![Rules](https://img.shields.io/badge/Rules-8-yellow)

## Table of Contents

- [Why This Config?](#why-this-config)
- [Design Principles](#design-principles)
- [Quick Start](#quick-start)
- [How to Talk to Claude](#how-to-talk-to-claude)
- [Architecture](#architecture)
- [Core Systems](#core-systems)
  - [Taxonomy](#taxonomy)
  - [Skills](#skills)
  - [Agents](#agents)
  - [Prompts](#prompts)
  - [Rules](#rules)
  - [Hooks](#hooks)
  - [Commands/Workflows](#commandsworkflows)
- [Common Workflows](#common-workflows)
- [Methodology](#methodology)
- [Repository Structure](#repository-structure)
- [Installation](#installation)
- [Configuration](#configuration)
- [Delegator Integration](#delegator-integration)
- [Contributing](#contributing)

## Why This Config?

Claude Code is powerful but lacks structure out of the box. Common pain points:

| Problem | Solution |
|---------|----------|
| Ad-hoc planning leads to scope creep | **Planning-with-files skill** — persistent markdown plans in `plans/` |
| No verification before "done" | **Verification skill** — enforces checks before completion |
| Large tasks become unmanageable | **Subagent-driven development** — parallel delegation |
| Inconsistent code style | **Rules** — path-scoped conventions auto-loaded |
| Missing context on patterns | **Skills** — inject domain knowledge when relevant |
| Manual workflow orchestration | **Commands/Workflows** — structured brainstorm→plan→work→review |

This config is **opinionated but modular**—use what fits your workflow.

## Design Principles

```
                    ┌─────────────────────────────────────────────┐
                    │         STRUCTURED DEVELOPMENT              │
                    │                                             │
                    │   Think  →  Plan  →  Execute  →  Verify    │
                    │                                             │
                    └─────────────────────────────────────────────┘
```

### Core Philosophy

| Principle | What It Means |
|-----------|---------------|
| **Plans over chat** | Decisions live in `plans/{slug}.md`, not buried in conversation |
| **Verify before done** | Tests must pass; linting must clear before marking complete |
| **Parallel when possible** | Large tasks delegate to parallel agents, not sequential steps |
| **Rules > reminders** | Path-scoped rules auto-inject, no need to repeat instructions |
| **Skills > prompts** | Reusable capabilities beat one-off prompt engineering |

### The Workflow Loop

```
   ┌──────────────────────────────────────────────────────────────────┐
   │                     THE DEVELOPMENT LOOP                         │
   └──────────────────────────────────────────────────────────────────┘

   1. BRAINSTORM                2. PLAN                 3. WORK
   ┌──────────────┐            ┌──────────────┐        ┌──────────────┐
   │              │            │              │        │              │
   │  Generate    │───────────▶│  Write plan  │───────▶│  Execute     │
   │  options &   │            │  to file     │        │  tasks with  │
   │  assess risk │            │  plans/*.md  │        │  status      │
   │              │            │              │        │  updates     │
   └──────────────┘            └──────────────┘        └──────────────┘
         │                            │                       │
         │                            │                       ▼
         │                            │               ┌──────────────┐
         │                            │               │ 4. REVIEW    │
         │                            │               │              │
         │                            │               │  Multi-agent │
         │                            │               │  code review │
         │                            │               │              │
         │                            │               └──────────────┘
         │                            │                       │
         │                            │                       ▼
         │                            │               ┌──────────────┐
         │                            │               │ 5. COMPOUND  │
         │                            │               │              │
         │                            │               │  Capture     │
         │                            │               │  solution in │
         │                            │               │  docs/       │
         │                            │               │              │
         │                            │               └──────────────┘
         │                            │                       │
         └─────────────◀──────────────┴───────────────────────┘
                              (iterate)
```

## Quick Start

```bash
# Clone and install
git clone https://github.com/Esk3nder/claude-code-config.git /tmp/claude-config
cd /tmp/claude-config
./install.sh

# Start Claude Code and try a workflow
claude
> /workflows/plan my-feature
```

See [Installation](#installation) for all options.

## How to Talk to Claude

You don't need to memorize commands. Describe what you want naturally—skills and workflows activate based on intent.

### Natural Language Examples

| What You Say | What Activates |
|--------------|----------------|
| "Build a user dashboard" | `planning-with-files` → `/workflows/plan` |
| "Fix this authentication bug" | `systematic-debugging` skill |
| "Review my changes" | `/workflows/review` → Codex adversarial pass + review agents |
| "I need to understand this codebase" | `codebase-search` agent |
| "Write tests for this function" | `test-driven-development` skill |
| "I'm done with this feature" | `finishing-a-development-branch` skill |
| "Run these tasks in parallel" | `dispatching-parallel-agents` skill |
| "How does library X work?" | `open-source-librarian` agent |

### First Session Commands

After installing, try these to explore:

| Command | What It Does |
|---------|--------------|
| `/workflows/plan my-feature` | Create a persistent plan file |
| `/workflows/brainstorm` | Generate options before committing |
| `/workflows/review` | Multi-agent code review |
| `/interview` | Interactive spec fleshing |

## Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                      CLAUDE CODE CONFIG                             │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐             │
│  │   Skills    │    │   Agents    │    │    Rules    │             │
│  │    (16)     │───▶│     (19)    │◀───│     (8)     │             │
│  └─────────────┘    └─────────────┘    └─────────────┘             │
│         │                  │                  │                     │
│         │                  │                  │                     │
│         ▼                  ▼                  ▼                     │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │                      WORKFLOWS                               │   │
│  │   brainstorm → plan → work → review → compound              │   │
│  └─────────────────────────────────────────────────────────────┘   │
│         │                  │                  │                     │
│         ▼                  ▼                  ▼                     │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐             │
│  │    Hooks    │    │  Commands   │    │   Plans     │             │
│  │     (4)     │    │     (9)     │    │  (files)    │             │
│  └─────────────┘    └─────────────┘    └─────────────┘             │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### Data Flow

```
    User Request              Planning                 Execution
         │                       │                         │
         ▼                       ▼                         ▼
    ┌─────────┐            ┌─────────┐              ┌─────────┐
    │ Skills  │            │ Create  │              │  Track  │
    │ inject  │───────────▶│ plan    │─────────────▶│ status  │
    │ context │            │ file    │              │ in file │
    └─────────┘            └─────────┘              └─────────┘
         │                       │                         │
         ├── Rules loaded        ├── plans/{slug}.md       ├── Task status
         ├── Hooks fire          ├── Verifiable steps      ├── Verification
         └── Agent hints         └── Risk assessment       └── Completion
```

## Core Systems

### Taxonomy

Understanding the building blocks:

| Type | What It Is | How It Works | Example |
|------|------------|--------------|---------|
| **Skill** | Single capability | Auto-activates based on context | `test-driven-development` |
| **Agent** | Specialized worker | Spawned on demand via Task tool | `codebase-search` |
| **Workflow** | Multi-step process | Triggered via `/command` | `/workflows/plan → work → review` |
| **Rule** | Path-scoped instruction | Auto-loaded for matching files | `typescript.md` for `*.ts` |
| **Hook** | Event listener | Fires on Claude Code events | `check-comments.py` on Edit |

```
┌─────────────────────────────────────────────────────────────────────────┐
│                          HOW THEY INTERACT                              │
└─────────────────────────────────────────────────────────────────────────┘

  User Message
       │
       ▼
  ┌─────────┐     ┌─────────┐     ┌─────────┐
  │  Rules  │────▶│ Skills  │────▶│ Agents  │
  │ (auto)  │     │ (auto)  │     │(spawned)│
  └─────────┘     └─────────┘     └─────────┘
       │               │               │
       └───────────────┴───────────────┘
                       │
                       ▼
                 ┌───────────┐
                 │  Hooks    │
                 │ (events)  │
                 └───────────┘
                       │
                       ▼
                 ┌───────────┐
                 │ Workflows │
                 │(/commands)│
                 └───────────┘
```

### Skills

Skills are model-invoked capabilities that inject domain knowledge and enforce patterns. Located in `.claude/skills/`.

#### Skill Categories

```
┌────────────────────────────────────────────────────────────────────┐
│                         SKILLS (16)                                │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│  PLANNING & STRUCTURE          DEVELOPMENT PATTERNS                │
│  ├── planning-with-files       ├── test-driven-development        │
│  ├── writing-plans             ├── systematic-debugging           │
│  ├── executing-plans           ├── subagent-driven-development    │
│  └── brainstorming             └── dispatching-parallel-agents    │
│                                                                    │
│  CODE REVIEW                   GIT & WORKFLOW                      │
│  ├── requesting-code-review    ├── finishing-a-development-branch │
│  └── receiving-code-review     ├── using-git-worktrees            │
│                                └── using-workflows                 │
│                                                                    │
│  QUALITY & VERIFICATION        AUTHORING                           │
│  └── verification-before-      └── writing-skills                  │
│      completion                                                    │
│                                                                    │
│  FRAMEWORK-SPECIFIC                                                │
│  └── react-useeffect                                               │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

#### Key Skills

| Skill | Purpose | When It Activates |
|-------|---------|-------------------|
| `planning-with-files` | Manus-style persistent planning | Multi-step tasks |
| `verification-before-completion` | Enforce tests/linting before done | Task completion |
| `subagent-driven-development` | Parallel delegation for large tasks | >5 parallelizable steps |
| `test-driven-development` | Red→Green→Refactor workflow | Writing tests |
| `systematic-debugging` | Reproduce→localize→fix methodology | Bug investigation |

### Agents

Agents are specialized subagents for specific domains. Located in `.claude/agents/`.

```
┌────────────────────────────────────────────────────────────────────┐
│                         AGENTS (19)                                │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│  EXPLORATION                   DOCUMENTATION                       │
│  └── codebase-search           └── tech-docs-writer               │
│                                                                    │
│  RESEARCH                      INTERPRETATION                      │
│  └── open-source-librarian     └── media-interpreter              │
│                                                                    │
│  ADVISORY (high-stakes decisions)                                  │
│  └── oracle                                                        │
│                                                                    │
│  CODE REVIEW (14 specialized reviewers)                            │
│  ├── agent-native              ├── architecture-strategist        │
│  ├── code-simplicity           ├── data-integrity-guardian        │
│  ├── data-migration-expert     ├── deployment-verification        │
│  ├── dhh-rails                 ├── frontend-races                 │
│  ├── pattern-recognition       ├── performance-oracle             │
│  ├── python                    ├── rails                          │
│  ├── security-sentinel         └── typescript                     │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

| Agent | Purpose | Use Case |
|-------|---------|----------|
| `codebase-search` | Find files and implementations | "Where is X defined?" |
| `open-source-librarian` | Research OSS with citations | "How does library Y work?" |
| `oracle` | High-stakes architecture and debugging | Complex decisions after failures |
| `media-interpreter` | Extract info from PDFs/images | Processing non-code files |
| `review/*` | Specialized code reviewers | Multi-perspective review |

### Prompts

Delegator expert prompts are loaded when routing to Codex experts. Stored in `.claude/prompts/delegator/`.

| Prompt | Purpose |
|--------|---------|
| `architect.md` | System design and tradeoff analysis |
| `plan-reviewer.md` | Plan completeness and verification |
| `scope-analyst.md` | Requirements ambiguity and scope |
| `code-reviewer.md` | Adversarial code review |
| `security-analyst.md` | Threat modeling and hardening |

### Rules

Rules are path-scoped instructions auto-loaded when working with matching files. Located in `.claude/rules/`.

| Rule | Scope | Purpose |
|------|-------|---------|
| `typescript.md` | `**/*.{ts,tsx}` | TypeScript conventions |
| `testing.md` | `**/*.{test,spec}.ts` | Testing patterns |
| `comments.md` | All files | Comment policy (no obvious comments) |
| `forge.md` | `**/*.sol` | Foundry/ZKsync Solidity rules |
| `delegator/orchestration.md` | Global | Codex orchestration flow |
| `delegator/triggers.md` | Global | Delegation trigger rules |
| `delegator/model-selection.md` | Global | Expert selection + modes |
| `delegator/delegation-format.md` | Global | 7-section delegation template |

### Hooks

Hooks are scripts triggered by Claude Code events. Located in `.claude/hooks/`.

| Hook | Event | Purpose |
|------|-------|---------|
| `keyword-detector.py` | UserPromptSubmit | Detect keywords, suggest skills |
| `check-comments.py` | PostToolUse (Write/Edit) | Validate comment policy |
| `todo-enforcer.sh` | Stop | Ensure todos are tracked |
| `require-green-tests.sh` | Stop | Block finish unless tests pass |

### Commands/Workflows

Commands provide structured workflows. Located in `.claude/commands/`.

```
┌────────────────────────────────────────────────────────────────────┐
│                      WORKFLOW COMMANDS                             │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│  /interview          Interactive planning and spec fleshing        │
│                                                                    │
│  /workflows/brainstorm   Generate options, assess risks            │
│       │                                                            │
│       ▼                                                            │
│  /workflows/plan         Create plans/{slug}.md with tasks         │
│       │                                                            │
│       ▼                                                            │
│  /workflows/work         Execute tasks, update status              │
│       │                                                            │
│       ▼                                                            │
│  /workflows/review       Multi-agent code review                   │
│       │                                                            │
│       ▼                                                            │
│  /workflows/compound     Capture solution in docs/solutions/       │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

Delegator commands:

| Command | Purpose |
|---------|---------|
| `/claude-delegator/setup` | Configure Codex MCP + install delegator rules/prompts |
| `/claude-delegator/task` | Delegate a task to a Codex expert |
| `/claude-delegator/uninstall` | Remove Codex MCP config and delegator rules/prompts |

## Common Workflows

Typical task patterns and the components they use:

```
┌──────────────────────────────────────────────────────────────────────────┐
│                         WORKFLOW PATTERNS                                │
└──────────────────────────────────────────────────────────────────────────┘

  NEW FEATURE                          BUG FIX
  ───────────                          ───────
  ┌──────────┐  ┌──────────┐           ┌──────────┐  ┌──────────┐
  │ /interview│─▶│ /plan    │           │systematic│─▶│  fix     │
  │ (clarify) │  │ (design) │           │-debugging│  │ (impl)   │
  └──────────┘  └────┬─────┘           └──────────┘  └────┬─────┘
                     │                                     │
                     ▼                                     ▼
              ┌──────────┐                          ┌──────────┐
              │ /work    │                          │ /review  │
              │(implement│                          │ (verify) │
              └────┬─────┘                          └────┬─────┘
                   │                                     │
                   ▼                                     ▼
              ┌──────────┐                          ┌──────────┐
              │ /review  │                          │ finishing│
              │ (verify) │                          │-branch   │
              └────┬─────┘                          └──────────┘
                   │
                   ▼
              ┌──────────┐
              │/compound │
              │ (capture)│
              └──────────┘


  CODE REVIEW                          PARALLEL WORK
  ───────────                          ─────────────
  ┌──────────┐  ┌──────────┐           ┌──────────┐  ┌──────────┐
  │ /review  │─▶│ review/* │           │subagent- │─▶│dispatching│
  │ (start)  │  │ agents   │           │driven-dev│  │-parallel │
  └──────────┘  └────┬─────┘           └──────────┘  └──────────┘
                     │                       │
                     ▼                       ▼
              ┌──────────────────────────────────┐
              │  Parallel agent execution:       │
              │  • Codex adversarial reviewer    │
              │  • typescript reviewer           │
              │  • security-sentinel             │
              │  • performance-oracle            │
              │  • architecture-strategist       │
              └──────────────────────────────────┘
```

### Quick Reference

| Task | Start With | Key Components | Output |
|------|------------|----------------|--------|
| **New Feature** | `/interview` | plan → work → review → compound | `plans/*.md` + `docs/solutions/` |
| **Bug Fix** | Describe bug | systematic-debugging → fix → review | Fixed code + tests |
| **Code Review** | `/workflows/review` | Codex adversarial pass + review agents | Findings in TodoWrite |
| **Refactor** | `/workflows/plan` | TDD skill → review agents | Verified changes |
| **Understand Codebase** | "Explain X" | codebase-search agent | Explanation |
| **Research Library** | "How does X work?" | open-source-librarian agent | Cited answer |

## Methodology

### The Plan/Code Workflow

This config enforces a **Plan → Code → Verify** methodology:

```
┌──────────────────────────────────────────────────────────────────────────┐
│                        PLAN / CODE / VERIFY                              │
└──────────────────────────────────────────────────────────────────────────┘

  PLAN PHASE                     CODE PHASE                  VERIFY PHASE
  ────────────                   ──────────                  ────────────
  ┌────────────┐                ┌────────────┐              ┌────────────┐
  │ Brainstorm │                │ Execute    │              │ Run tests  │
  │ options    │                │ plan tasks │              │ & linting  │
  └─────┬──────┘                └─────┬──────┘              └─────┬──────┘
        │                             │                           │
        ▼                             ▼                           ▼
  ┌────────────┐                ┌────────────┐              ┌────────────┐
  │ Write plan │                │ Update     │              │ Multi-agent│
  │ to file    │                │ status in  │              │ review     │
  │            │                │ plan file  │              │            │
  └─────┬──────┘                └─────┬──────┘              └─────┬──────┘
        │                             │                           │
        ▼                             ▼                           ▼
  ┌────────────┐                ┌────────────┐              ┌────────────┐
  │ Assess     │                │ Checkpoint │              │ Capture    │
  │ risks      │                │ progress   │              │ learnings  │
  └────────────┘                └────────────┘              └────────────┘

  Output:                        Output:                     Output:
  plans/{slug}.md                Updated plan file           docs/solutions/
  with verifiable tasks          with [x] completed          reusable patterns
```

### Task Classification

The CLAUDE.md defines behavior based on task complexity:

| Complexity | Signals | Behavior |
|------------|---------|----------|
| **Trivial** | Single file, obvious fix | Direct execution |
| **Moderate** | Non-trivial logic, single module | Plan briefly, then execute |
| **Complex** | Cross-module, migrations, protocols | Full Plan→Code workflow |

### Verification Requirements

Before marking any task complete:

| Check | Required |
|-------|----------|
| Tests pass | Yes |
| Linting clean | Yes |
| Type checking | Yes (if applicable) |
| Plan file updated | Yes (for workflow tasks) |

## Repository Structure

```
claude-code-config/
├── README.md                 # This file
├── CLAUDE.md                 # Global instructions for all sessions
├── INSTALL.md                # Copy-paste install prompt
├── install.sh                # Installation script
│
├── skills/                   # Model-invoked capabilities (16)
│   ├── planning-with-files/
│   │   ├── SKILL.md          # Skill definition
│   │   ├── examples.md       # Usage examples
│   │   └── reference.md      # API reference
│   ├── test-driven-development/
│   ├── verification-before-completion/
│   ├── systematic-debugging/
│   ├── react-useeffect/
│   └── ...
│
├── agents/                   # Specialized subagents (19)
│   ├── codebase-search.md
│   ├── media-interpreter.md
│   ├── open-source-librarian.md
│   ├── oracle.md
│   ├── tech-docs-writer.md
│   └── review/               # Code review specialists (14)
│       ├── index.md          # Review agent orchestrator
│       ├── typescript.md
│       ├── python.md
│       ├── security-sentinel.md
│       └── ...
│
├── rules/                    # Path-scoped instructions (8)
│   ├── typescript.md         # **/*.{ts,tsx}
│   ├── testing.md            # **/*.{test,spec}.ts
│   ├── comments.md           # All files
│   ├── forge.md              # **/*.sol
│   └── delegator/            # Codex delegation rules
│       ├── orchestration.md
│       ├── triggers.md
│       ├── model-selection.md
│       └── delegation-format.md
│
├── prompts/                  # Codex expert prompts (5)
│   └── delegator/
│       ├── architect.md
│       ├── plan-reviewer.md
│       ├── scope-analyst.md
│       ├── code-reviewer.md
│       └── security-analyst.md
│
├── hooks/                    # Event-triggered scripts (4)
│   ├── keyword-detector.py   # UserPromptSubmit
│   ├── check-comments.py     # PostToolUse
│   ├── todo-enforcer.sh      # Stop
│   └── workflows/
│       └── require-green-tests.sh  # Stop
│
├── commands/                 # Slash commands (9)
│   ├── interview.md          # /interview
│   ├── workflows/
│       ├── brainstorm.md     # /workflows/brainstorm
│       ├── plan.md           # /workflows/plan
│       ├── work.md           # /workflows/work
│       ├── review.md         # /workflows/review
│       └── compound.md       # /workflows/compound
│   └── claude-delegator/
│       ├── setup.md          # /claude-delegator/setup
│       ├── task.md           # /claude-delegator/task
│       └── uninstall.md      # /claude-delegator/uninstall
│
├── config/                   # Config snippets
│   └── delegator/
│       ├── mcp-servers.example.json
│       ├── providers.json
│       └── experts.json
│
└── docs/                     # Documentation
    ├── workflows-integration.md
    └── delegator-integration.md
```

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

### Option 2: Copy-Paste into Claude Code

Copy the prompt from [INSTALL.md](INSTALL.md) and paste it into Claude Code. Claude will fetch and install all config files automatically.

### Option 3: Git Clone (Direct)

```bash
git clone https://github.com/Esk3nder/claude-code-config.git ~/.claude
cp ~/.claude/settings.json.example ~/.claude/settings.json
```

### Option 4: Selective Install

```bash
git clone https://github.com/Esk3nder/claude-code-config.git /tmp/claude-config

# Copy what you need
cp -r /tmp/claude-config/rules/* ~/.claude/rules/
cp -r /tmp/claude-config/skills/* ~/.claude/skills/
cp -r /tmp/claude-config/agents/* ~/.claude/agents/
```

## Configuration

### settings.json

Central configuration for hooks. Created by `install.sh`:

```json
{
  "hooks": {
    "UserPromptSubmit": [...],
    "PostToolUse": [...],
    "Stop": [...]
  }
}
```

### CLAUDE.md

Global instructions loaded into every session. Defines:
- Task classification (trivial/moderate/complex)
- Plan/Code workflow rules
- Risk boundaries
- Verification requirements

## Delegator Integration

This config vendors claude-delegator rules, prompts, and commands for Codex expert delegation.

- Setup: run `/claude-delegator/setup` (requires Codex CLI + `codex login`)
- Prompts: `~/.claude/prompts/delegator/*.md` (customized expert behavior)
- Mapping: `config/delegator/experts.json`
- Details: `docs/delegator-integration.md`

## Recommended Plugins

```bash
# Official plugins
claude plugin install frontend-design
claude plugin install code-review
claude plugin install typescript-lsp
claude plugin install plugin-dev
claude plugin install ralph-loop

# claude-hud (status line)
claude plugin marketplace add jarrodwatts/claude-hud
claude plugin install claude-hud@claude-hud

# Codex delegation (bundled in this repo)
# Run /claude-delegator/setup to configure MCP
```

## Contributing

Contributions welcome! Areas of interest:
- New skills for common workflows
- Additional review agents
- Hooks for other events
- Rules for other languages/frameworks

## Acknowledgments

This config is sourced from many talented people in the community:
- [jarrodwatts/claude-code-config](https://github.com/jarrodwatts/claude-code-config) — Community-maintained Claude Code configuration patterns
- [EveryInc/compound-engineering-plugin](https://github.com/EveryInc/compound-engineering-plugin) — Engineering workflow patterns for compound AI systems
- [obra/superpowers](https://github.com/obra/superpowers) — Agent orchestration patterns
- [numman-ali](https://github.com/numman-ali) — Continuity patterns
- [parcadei/Continuous-Claude-v3](https://github.com/parcadei/Continuous-Claude-v3) — Inspiration for structure
- The Claude Code community

## License

MIT — Use freely, contribute back.
