---
title: Plans vs Docs Directory Reorganization
date: 2026-01-13
tags: [repo-structure, documentation, planning, refactoring]
related_plans:
  - plans/backlog.md
  - plans/20260112-output-format-standardization.md
category: repo-structure
---

# Plans vs Docs Directory Reorganization

## Problem

The repository had `plans/` gitignored and mixed planning/design documents with user-facing documentation in `docs/`. This created confusion about:
- What belongs in each directory
- What should be version controlled
- How agents should use these directories for planning vs documentation

## Root Cause

Initial design didn't distinguish between:
- **Internal planning docs** (how we build the system)
- **User-facing docs** (how to use the system)

Both were being stored in `docs/`, and `plans/` was gitignored as if it were temporary working state.

## Solution

### 1. Clarified Directory Purpose

**plans/** - Internal planning and design documents (committed to git):
- Feature planning and task breakdowns
- Design decisions and architectural choices
- Work backlogs and roadmaps
- Audit results and analysis
- Implementation strategies
- Captured solutions (Compound workflow)

**docs/** - User-facing documentation (committed to git):
- Setup guides
- Integration documentation
- Test plans
- How-to guides

### 2. Reorganization Steps

```bash
# 1. Update .gitignore to track plans/
# Added: !plans/ and !plans/**

# 2. Move files from docs/ to plans/
git mv docs/audit/ plans/audit/
git mv docs/backlog.md plans/backlog.md
git mv docs/metrics-schema.md plans/metrics-schema.md
git mv docs/solutions/ plans/solutions/

# 3. Create README.md in both directories
# Explained purpose of each directory

# 4. Update all cross-references
# Changed docs/solutions/ → plans/solutions/ in 11 files:
- README.md (3 references)
- skills/ManagingPlans/SKILL.md (2 references)
- skills/Compound/SKILL.md (3 references)
- commands/workflows/compound.md (2 references)
- hooks/keyword-detector.py (1 reference)
- docs/capability-test-plan.md (2 references)
- docs/workflows-integration.md (1 reference)
- plans/audit/graph.json (1 reference)
```

### 3. Dead Code Detection & Fixes

After reorganization, searched for dead code references:

```bash
# Search for old paths
grep -r "docs/solutions/" .
grep -r "docs/audit/" .
grep -r "docs/backlog" .

# Found 1 dead reference:
# tests/structure_test.sh:55 - assert_dir_exists "docs/solutions"
```

**Fixed**:
1. Changed `docs/solutions` → `plans/solutions` in structure test
2. Excluded `agents/README.md` from agent count (documentation, not agent definition)

## Verification

### 1. Comprehensive Search
```bash
# Verified no references to old paths
grep -r "docs/(audit|solutions|backlog|metrics)" .
# Result: 0 matches ✅

# Checked for broken symlinks
find . -type l -xtype l
# Result: None ✅

# Checked for empty directories
find . -type d -empty | grep -v ".git"
# Result: Only .claude/.state (expected) ✅
```

### 2. Test Suite
```bash
bash tests/structure_test.sh
# Result: ALL PASSED ✅
# - Skills: 17/17
# - Agents: 19/19
# - Hooks: 5/5
# - Rules: 8/8
```

### 3. Git Status
```bash
git status
# Result: Working tree clean ✅
```

## Files Changed

### Created
- `plans/README.md` - Explains planning docs structure
- `docs/README.md` - Explains user documentation
- `agents/README.md` - Capability matrix for 20 agents
- `plans/20260112-output-format-standardization.md` - RFC for agent outputs

### Moved
- `docs/audit/*` (12 files) → `plans/audit/`
- `docs/backlog.md` → `plans/backlog.md`
- `docs/metrics-schema.md` → `plans/metrics-schema.md`
- `docs/solutions/` → `plans/solutions/`

### Modified (cross-reference updates)
- `.gitignore` - Added plans/ tracking
- `README.md` - Updated directory structure
- `skills/ManagingPlans/SKILL.md`
- `skills/Compound/SKILL.md`
- `commands/workflows/compound.md`
- `hooks/keyword-detector.py`
- `docs/capability-test-plan.md`
- `docs/workflows-integration.md`
- `plans/audit/graph.json`
- `tests/structure_test.sh`

## Commits

1. **8b31388** - `refactor: Reorganize plans/ and docs/ directories`
   - 27 files changed, 873 insertions, 17 deletions

2. **57fa5f4** - `fix: Update structure test for plans/ reorganization`
   - 1 file changed, 2 insertions, 2 deletions

## Key Insights

### Pattern: Multi-Step Refactoring Safety
1. **Move files first** (git mv preserves history)
2. **Update references systematically** (use grep to find all)
3. **Search for dead code** (parallel searches with multiple patterns)
4. **Run tests** (catch broken assumptions)
5. **Verify working tree clean** (no loose ends)

### Pattern: Directory Purpose Documentation
When reorganizing directories, create README.md in each explaining:
- What goes there (with examples)
- What doesn't go there
- How it's used by the system
- Naming conventions

### Gotcha: Test Suite Assumptions
Tests may hardcode directory paths. After reorganization:
- Search test files for old paths
- Run full test suite before committing
- Update expected counts if documentation files added

### Gotcha: Hidden References
References can hide in:
- Test files
- Hook scripts
- Agent prompts
- Audit/analysis files
- Git history references

Use exhaustive parallel searches:
```bash
grep -r "pattern1" . &
grep -r "pattern2" . &
grep -r "pattern3" . &
wait
```

## Prevention

1. **Document directory purpose upfront** - Create README.md explaining what goes where
2. **Use skill references** - Let skills reference directory locations, not hardcode them everywhere
3. **Test after moves** - Always run structure tests after reorganizing
4. **Parallel search for dead code** - Use multiple grep patterns to catch all references

## Related Issues

- Initial confusion: "why is plans/ gitignored?"
- User expectation: "we should just be using plans to plan our work"
- Correct understanding: plans/ = internal planning (committed), docs/ = user guides (committed)
