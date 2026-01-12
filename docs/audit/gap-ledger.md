# Gap Ledger

**Last Updated:** 2026-01-12 (Pass 3)

## Summary

| Severity | Open | Resolved | Total |
|----------|------|----------|-------|
| P0 (Critical) | 0 | 0 | 0 |
| P1 (High) | 2 | 1 | 3 |
| P2 (Medium) | 6 | 1 | 7 |
| P3 (Low) | 0 | 1 | 1 |

---

## P1 - High Priority

### GAP-001: keyword-detector only suggests, does not enforce
**Status:** RESOLVED (Pass 3)
**Resolution:** PreToolUse hook (`parallel-dispatch-guide.py`) now reads context flags set by keyword-detector and auto-dispatches agents when score >= 3.

**How it works:**
1. UserPromptSubmit: keyword-detector writes flags to `~/.claude/hooks/state/session-context.json`
2. PreToolUse: parallel-dispatch-guide reads flags, calculates score, dispatches agents
3. Score thresholds: review_security=3, review_performance=3, exploration_mode=2, etc.
4. Agents dispatched in background mode automatically

**Evidence:**
- `hooks/keyword-detector.py:100-168` - writes context flags
- `hooks/parallel-dispatch-guide.py:82-93` - reads context flags
- `hooks/parallel-dispatch-guide.py:237-245` - auto-dispatch logic

**Remaining concern:** Model can still ignore suggestions, but enforcement is now partial via PreToolUse

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
**Status:** RESOLVED (Pass 3)
**Resolution:** `hooks/parallel-dispatch-guide.py` implemented as PreToolUse hook.

**Implementation details:**
- Matcher: `Read|Grep|Glob|Bash`
- Reads context flags from keyword-detector
- Score-based dispatch (MIN_SCORE_TO_DISPATCH = 3)
- Tracks exploration count in session window (60 seconds)
- Dispatches max 5 agents per session
- Agents: security-sentinel, performance-oracle, architecture-strategist, code-simplicity, pattern-recognition, codebase-search, open-source-librarian

**Evidence:**
- `hooks/parallel-dispatch-guide.py` (251 lines)
- `settings.json.example:13-22` - PreToolUse configuration

---

## Audit Trail

| Pass | Date | Gaps Added | Gaps Resolved |
|------|------|------------|---------------|
| 1 | 2026-01-11 | GAP-004, 006, 009, 013, 015-020 | - |
| 2 | 2026-01-12 | GAP-001, 012 | GAP-015 |
| 3 | 2026-01-12 | - | GAP-001, GAP-012 |
