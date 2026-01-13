# Goal
Add CONTEXT_PLANNING injection to keyword-detector.py so non-trivial tasks automatically get plan-file guidance.

## Constraints
- Must not break existing keyword detection behavior
- Should integrate with existing priority chain
- Pattern should detect implementation-heavy requests

## Tasks
- [x] Task 1: Review current hook structure → `hooks/keyword-detector.py` → verify pattern chain understood <!-- completed: 2026-01-13 -->
- [ ] Task 2: Define CONTEXT_PLANNING content → inline in hook → matches CLAUDE.md guidance
- [ ] Task 3: Add pattern for non-trivial detection → PATTERNS_SKILLS → covers "add feature", "implement", "build"
- [ ] Task 4: Wire CONTEXT_PLANNING into priority chain → main() → appropriate priority level
- [ ] Task 5: Test hook with sample prompts → manual verification → confirm injection works

## Verification
- [ ] Hook runs without errors
- [ ] Non-trivial prompts get CONTEXT_PLANNING injected
- [ ] Trivial prompts still work as before

## Notes
- This is Phase 3 (optional) from integration-plan.md
- Only needed if CLAUDE.md instructions alone don't produce consistent behavior
- **Task 1 findings**: Hook has 7 pattern tiers, "planning" pattern exists at line 88 but only sets a flag without injecting context. Need to add CONTEXT_PLANNING block and wire it into priority chain around Priority 7 (skill activation patterns).
