# Gap Ledger

**Last Updated:** 2026-01-12 (Pass 2)

## Summary

| Severity | Open | Resolved | Total |
|----------|------|----------|-------|
| P0 (Critical) | 0 | 0 | 0 |
| P1 (High) | 3 | 0 | 3 |
| P2 (Medium) | 6 | 1 | 7 |
| P3 (Low) | 1 | 0 | 1 |

---

## P1 - High Priority

### GAP-001: keyword-detector only suggests, does not enforce
**Status:** OPEN
**Risk:** Model may ignore context suggestions; no deterministic routing guarantee
**Evidence:** `hooks/keyword-detector.py:main()` - outputs `hookSpecificOutput.additionalContext` only
**Failing Test Idea:**
```python
def test_keyword_detector_does_not_dispatch():
    """Verify keyword-detector returns context, not agent dispatch."""
    # Input with "search" keyword
    result = run_hook("keyword-detector.py", {"prompt": "search for files"})
    assert "hookSpecificOutput" in result
    assert "additionalContext" in result["hookSpecificOutput"]
    # No agent was actually dispatched - only context was injected
```
**Fix:** Either:
1. Accept this as design (soft suggestions) and document
2. Add actual dispatch logic via PreToolUse hook to enforce routing

---

### GAP-004: TOCTOU race in require-green-tests.sh cache
**Status:** OPEN
**Risk:** Cache check (mtime comparison) can pass while file is being modified
**Evidence:** `hooks/workflows/require-green-tests.sh:195-198`
```bash
if [[ "$PREV_STATUS" == "green" && -n "$CMD_HASH" && "$PREV_CMD_HASH" == "$CMD_HASH" && "$PREV_MTIME" -ge "$LATEST_MTIME" ]]; then
```
**Failing Test Idea:**
```bash
# Race condition test
touch test.ts && sleep 0.1 && echo "pass" > .state
# Immediately modify test.ts while cache says "green"
echo "fail" >> test.ts
./require-green-tests.sh  # Should run tests, but may use cache
```
**Fix:** Add file hash comparison, not just mtime

---

### GAP-009: Missing dependency check for jq
**Status:** OPEN
**Risk:** todo-enforcer.sh fails silently if jq not installed
**Evidence:** `hooks/todo-enforcer.sh:27-29`
```bash
if ! command -v jq &>/dev/null; then
  die "jq is required but not installed"
fi
```
Note: `die` calls `exit 0` which allows completion - wrong behavior!
**Failing Test Idea:**
```bash
# Remove jq from PATH temporarily
PATH=/bin:/usr/bin ./todo-enforcer.sh
# Should block exit, not allow it
```
**Fix:** Change `die()` to output `{"decision": "block", ...}` for missing dependencies

---

## P2 - Medium Priority

### GAP-006: Information disclosure in debug logs
**Status:** OPEN
**Risk:** Sensitive code content written to `~/.claude/hooks/debug.log` unbounded
**Evidence:** `hooks/check-comments.py:141-143`
```python
with open(debug_log, "a") as f:
    f.write(f"Raw input: {raw_input[:2000]}\n")
```
**Failing Test Idea:**
```python
# Check log file size after multiple invocations
initial_size = os.path.getsize(debug_log)
for _ in range(1000):
    run_hook("check-comments.py", large_input)
final_size = os.path.getsize(debug_log)
assert final_size < MAX_LOG_SIZE_MB * 1024 * 1024
```
**Fix:** Add log rotation or size limit

---

### GAP-013: Unclear skill activation semantics
**Status:** OPEN
**Risk:** Skills activate via implicit context matching, not explicit registration
**Evidence:** Skills have `USE WHEN` clauses in description but no code enforces them
**Failing Test Idea:** N/A (design documentation needed)
**Fix:** Document skill activation mechanism clearly

---

### GAP-015: Review agent dispatch documentation mismatch
**Status:** RESOLVED (Pass 2)
**Resolution:** Routing IS conditional per file type - see `commands/workflows/review.md:18-31`
**Evidence:** Agent Routing Table in review.md shows file-type based selection

---

### GAP-016: No explicit routing for resume/incremental work
**Status:** OPEN
**Risk:** `/workflows/resume` mentioned but not implemented as command
**Evidence:** File `commands/workflows/resume.md` exists but not in graph routing
**Failing Test Idea:**
```bash
# Verify resume command exists and routes correctly
claude /workflows/resume
# Should load and continue previous plan
```
**Fix:** Add resume command to graph and verify implementation

---

### GAP-017: Inconsistent tool allowlists across commands
**Status:** OPEN
**Risk:** Some commands have `Task` in allowedTools, others don't
**Evidence:**
- `/workflows/review` has `Task` (line 2)
- `/workflows/plan` does NOT have `Task`
**Failing Test Idea:**
```python
# Compare tool allowlists for consistency
plan_tools = extract_allowed_tools("commands/workflows/plan.md")
review_tools = extract_allowed_tools("commands/workflows/review.md")
# Both should have Task for subagent dispatch
```
**Fix:** Audit and standardize tool allowlists

---

### GAP-018: Unbounded debug logging
**Status:** OPEN
**Risk:** `~/.claude/hooks/debug.log` grows without limit
**Evidence:** `hooks/check-comments.py` appends to log without rotation
**See also:** GAP-006 (same root cause)

---

### GAP-019: No documentation of hook ordering guarantees
**Status:** OPEN
**Risk:** Multiple Stop hooks (require-green-tests, todo-enforcer) run - order undefined
**Evidence:** `settings.json.example` shows two separate Stop hook blocks
**Failing Test Idea:**
```python
# Test that both hooks run regardless of order
# Verify both can block independently
```
**Fix:** Document that Stop hooks run in parallel, both must pass

---

### GAP-020: Codex MCP tool can bypass 7-section structure
**Status:** OPEN
**Risk:** Direct `mcp__codex__codex` calls don't enforce delegation format rules
**Evidence:** `commands/claude-delegator/task.md` defines format but tool doesn't validate
**Failing Test Idea:**
```python
# Call codex tool with malformed prompt
result = mcp__codex__codex(prompt="just do something")
# Should reject or warn about missing sections
```
**Fix:** Add validation in task.md prompt or wrapper

---

## P3 - Low Priority

### GAP-012: No PreToolUse hook for parallel agent auto-dispatch
**Status:** OPEN
**Risk:** User must manually invoke parallel agents even when context suggests them
**Evidence:** keyword-detector only injects context, doesn't trigger actual dispatch
**Failing Test Idea:** N/A (enhancement request)
**Fix:** Consider adding PreToolUse hook to auto-dispatch when context detected

---

## Audit Trail

| Pass | Date | Gaps Added | Gaps Resolved |
|------|------|------------|---------------|
| 1 | 2026-01-11 | GAP-004, 006, 009, 013, 015-020 | - |
| 2 | 2026-01-12 | GAP-001, 012 | GAP-015 |
