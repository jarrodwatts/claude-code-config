# Backlog

## Complexity Reduction

**Goal:** Reduce repo complexity by ~1,700 lines while improving clarity and maintainability.

### P0 - Critical
- [ ] Merge `WritingPlans` + `PlanningWithFiles` into single `ManagingPlans` skill
- [ ] Remove duplicate task management section from CLAUDE.md (~60 lines) - reference skill instead

### P1 - High
- [ ] Consolidate `rules/delegator/` from 4 files to 2 (merge orchestration+triggers+model-selection into `delegation-guide.md`)
- [ ] Delete all 19 empty `skills/*/Tools/` directories

### P2 - Medium
- [ ] Consolidate review agents: merge `data-migration-expert` + `data-integrity-guardian` into `data-safety`
- [ ] Archive old audit passes in `docs/audit/` - keep only latest snapshot
- [ ] Split CLAUDE.md into modular files: `role.md`, `behavior.md`, `constraints.md`

### P3 - Low
- [ ] Clarify/deprecate unused `commands/interview.md`
- [ ] Confirm `agents/media-interpreter.md` is used or deprecate
- [ ] Merge `config/delegator/providers.json` into `experts.json`
- [ ] Document naming convention (Skills=CamelCase, agents=kebab-case) in README
