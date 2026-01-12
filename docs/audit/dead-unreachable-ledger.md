# Dead/Unreachable Ledger

**Generated**: 2026-01-12

## Summary

| Category | Count |
|----------|-------|
| Dead Code | 0 |
| Unreachable Components | 0 |
| Orphan Files | 0 |
| Broken References | 0 |

## Analysis Methodology

### Referenced-By Scan
For each component type, verified that it is referenced by:
- Install documentation (INSTALL.md)
- Configuration files
- Other components
- Claude Code runtime discovery patterns

### Can-Run Scan
For executable scripts, verified:
- Shebang line present
- Correct interpreter path
- Dependencies available (or documented)
- Path resolution correct

### Install Coverage Scan
Verified that INSTALL.md includes paths for all components that need installation.

## Components Verified

### Skills (16/16 reachable)
All skills are discovered by Claude Code via `~/.claude/skills/*/SKILL.md` pattern.

| Skill | Referenced In INSTALL.md | Has SKILL.md |
|-------|-------------------------|--------------|
| planning-with-files | ✓ | ✓ |
| react-useeffect | ✓ | ✓ |
| using-workflows | ✓ | ✓ |
| brainstorming | ✓ | ✓ |
| writing-plans | ✓ | ✓ |
| executing-plans | ✓ | ✓ |
| subagent-driven-development | ✓ | ✓ |
| dispatching-parallel-agents | ✓ | ✓ |
| test-driven-development | ✓ | ✓ |
| verification-before-completion | ✓ | ✓ |
| systematic-debugging | ✓ | ✓ |
| requesting-code-review | ✓ | ✓ |
| receiving-code-review | ✓ | ✓ |
| finishing-a-development-branch | ✓ | ✓ |
| using-git-worktrees | ✓ | ✓ |
| writing-skills | ✓ | ✓ |

### Agents (19/19 reachable)
All agents are discovered by Claude Code via `~/.claude/agents/**/*.md` pattern.

| Agent | Referenced In INSTALL.md |
|-------|-------------------------|
| codebase-search.md | ✓ |
| media-interpreter.md | ✓ |
| open-source-librarian.md | ✓ |
| oracle.md | ✓ |
| tech-docs-writer.md | ✓ |
| review/security-sentinel.md | ✓ |
| review/performance-oracle.md | ✓ |
| review/architecture-strategist.md | ✓ |
| review/data-migration-expert.md | ✓ |
| review/deployment-verification.md | ✓ |
| review/code-simplicity.md | ✓ |
| review/data-integrity-guardian.md | ✓ |
| review/pattern-recognition.md | ✓ |
| review/agent-native.md | ✓ |
| review/typescript.md | ✓ |
| review/rails.md | ✓ |
| review/python.md | ✓ |
| review/dhh-rails.md | ✓ |
| review/frontend-races.md | ✓ |

### Commands (9/9 reachable)
All commands are discovered by Claude Code via `~/.claude/commands/**/*.md` pattern.

| Command | Referenced In INSTALL.md |
|---------|-------------------------|
| interview.md | ✓ |
| workflows/brainstorm.md | ✓ |
| workflows/plan.md | ✓ |
| workflows/work.md | ✓ |
| workflows/review.md | ✓ |
| workflows/compound.md | ✓ |
| claude-delegator/setup.md | ✓ |
| claude-delegator/task.md | ✓ |
| claude-delegator/uninstall.md | ✓ |

### Hooks (4/4 reachable)
All hooks are referenced in INSTALL.md hook wiring section.

| Hook | Referenced In INSTALL.md | Shebang | Executable Check |
|------|-------------------------|---------|------------------|
| keyword-detector.py | ✓ | `#!/usr/bin/env python3` | Needs chmod +x |
| check-comments.py | ✓ | `#!/usr/bin/env python3` | Needs chmod +x |
| todo-enforcer.sh | ✓ | `#!/usr/bin/env bash` | Needs chmod +x |
| workflows/require-green-tests.sh | ✓ | `#!/usr/bin/env bash` | Needs chmod +x |

### Rules (8/8 reachable)
All rules are discovered by Claude Code via `~/.claude/rules/**/*.md` pattern.

| Rule | Referenced In INSTALL.md |
|------|-------------------------|
| typescript.md | ✓ |
| testing.md | ✓ |
| comments.md | ✓ |
| forge.md | ✓ |
| delegator/orchestration.md | ✓ |
| delegator/triggers.md | ✓ |
| delegator/model-selection.md | ✓ |
| delegator/delegation-format.md | ✓ |

### Prompts (5/5 reachable)
All prompts are mapped in config/delegator/experts.json.

| Prompt | Referenced In experts.json |
|--------|---------------------------|
| delegator/architect.md | ✓ (expert: architect) |
| delegator/plan-reviewer.md | ✓ (expert: plan-reviewer) |
| delegator/scope-analyst.md | ✓ (expert: scope-analyst) |
| delegator/code-reviewer.md | ✓ (expert: code-reviewer) |
| delegator/security-analyst.md | ✓ (expert: security-analyst) |

### Config (3/3 reachable)
All config files are referenced in INSTALL.md.

| Config | Referenced In INSTALL.md |
|--------|-------------------------|
| delegator/mcp-servers.example.json | ✓ |
| delegator/providers.json | ✓ |
| delegator/experts.json | ✓ |

## Minor Issues Found

None.

## Unused But Intentional

The following are not "dead code" but rather support files:

| File | Purpose | Why Not Dead |
|------|---------|--------------|
| skills/*/examples.md | Skill examples | Referenced by SKILL.md |
| skills/*/reference.md | Skill reference | Referenced by SKILL.md |
| skills/*/alternatives.md | Alternative patterns | Referenced by SKILL.md |
| skills/*/anti-patterns.md | Anti-patterns | Referenced by SKILL.md |
| agents/review/index.md | Review agent index | Meta-file for organization |

## Conclusion

**No dead or unreachable code found.** All components in the repository are:
1. Referenced in INSTALL.md for installation
2. Discoverable by Claude Code runtime patterns
3. Have valid internal references

The repository is well-organized with complete wiring coverage, and core install wiring is present (`install.sh` + `settings.json.example`).
