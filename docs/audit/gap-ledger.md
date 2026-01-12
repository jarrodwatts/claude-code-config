# Gap & Missing Features Ledger

**Generated**: 2026-01-11

## Summary by Severity

| Severity | Count | Description |
|----------|-------|-------------|
| P0 | 0 | Critical: security vulnerability |
| P1 | 1 | High: TOCTOU race in test cache |
| P2 | 5 | Medium: Info disclosure, robustness, maintenance, UX |

## P0 - Critical Issues

### GAP-001: install.sh Does Not Exist
- **Status**: RESOLVED
- **Evidence**:
  - `install.sh` exists at repo root
  - `tests/structure_test.sh` asserts `install.sh` exists

### GAP-002: Command Injection via WORKFLOWS_TEST_CMD
- **Status**: RESOLVED
- **Evidence**: hooks/workflows/require-green-tests.sh now validates `WORKFLOWS_TEST_CMD`/`SUPERPOWERS_TEST_CMD` (rejects unsafe characters + non-test commands) and shells out via a safely-quoted `bash -lc` command

## P1 - High Priority Issues

### GAP-003: Code Execution via State File Sourcing
- **Status**: RESOLVED
- **Evidence**: hooks/workflows/require-green-tests.sh no longer `source`s the state file; it parses expected keys and validates values

### GAP-004: TOCTOU Race in Test Cache
- **Type**: Security footgun / Reliability gap
- **Severity**: P1
- **Evidence**: hooks/workflows/require-green-tests.sh caches `PREV_STATUS`, `PREV_CMD_HASH`, and `PREV_MTIME` and compares `PREV_MTIME` to the newest tracked file mtime; there is no locking around the cache check/update
- **Impact**: Tests may be skipped when the working tree changes between cache check and cache write
- **Minimal Fix**: Add file lock or atomic cache update
- **Verification**: Manual race condition test

### GAP-005: No Automated Installation Verification
- **Status**: RESOLVED
- **Evidence**: `.github/workflows/ci.yml` now runs `structure_test.sh` and `schema_test.py` on push/PR to main

## P2 - Medium Priority Issues

### GAP-006: Information Disclosure in Logs
- **Type**: Security footgun
- **Severity**: P2
- **Evidence**: hooks/workflows/require-green-tests.sh prints test output to console (now truncated by default via `WORKFLOWS_TEST_MAX_OUTPUT_LINES`, default 200)
- **Impact**: Test output may contain secrets, API keys, or sensitive data
- **Minimal Fix**: Filter sensitive patterns and/or default to less verbose output (opt-in to full output)
- **Verification**: Review logged output for sensitive data patterns

### GAP-007: Temp File Permissions
- **Type**: Security footgun
- **Severity**: P2
- **Status**: RESOLVED
- **Evidence**: hooks/workflows/require-green-tests.sh sets `umask 077` before creating state/output files

### GAP-008: API Key Examples in Docs
- **Type**: Security footgun
- **Severity**: P2
- **Status**: RESOLVED / NOT APPLICABLE
- **Evidence**: config/delegator/mcp-servers.example.json does not include API keys (Codex CLI auth uses `codex login`)

### GAP-009: Missing Dependency Checks
- **Type**: Reliability gap
- **Severity**: P2
- **Evidence**:
  - todo-enforcer.sh checks for `jq` but only logs to `~/.claude/hooks/todo-enforcer.log` and exits 0 (no user-facing warning)
  - Python hooks rely on `python3` at runtime; manual install path does not include a preflight check
- **Impact**: Silent failures if dependencies missing
- **Minimal Fix**: Add dependency checks at script start
- **Verification**:
  ```bash
  # Hide jq temporarily and confirm the missing-dependency path is surfaced (or at least logged)
  PATH="/usr/bin:/bin" ./hooks/todo-enforcer.sh || true
  tail -n 20 ~/.claude/hooks/todo-enforcer.log || true
  ```

### GAP-010: No Schema Validation for Config
- **Type**: Maintenance gap
- **Severity**: P2
- **Evidence**: No formal JSON schema for config/delegator/*.json files (basic validation exists in tests/schema_test.py)
- **Impact**: Invalid config not caught until runtime
- **Minimal Fix**: Add JSON schemas and validation script
- **Verification**:
  ```bash
  python3 tests/schema_test.py
  ```

## Routing/Hook Gaps

### GAP-011: No Hook Firing on Abort
- **Type**: Hook gap
- **Severity**: P2
- **Evidence**: User Ctrl+C triggers Stop hooks normally
- **Impact**: Actually NOT a gap - Stop hooks fire on all exits including abort
- **Status**: Verified working as expected

### GAP-012: No Preflight Hook
- **Type**: Feature gap
- **Severity**: P2
- **Evidence**: No PreToolUse hook type available
- **Impact**: Cannot validate/intercept tool calls before execution
- **Note**: This is a Claude Code platform limitation, not repo gap
- **Status**: Not actionable in this repo

## UX Gaps

### GAP-013: Unclear Skill Activation Semantics
- **Type**: UX gap
- **Severity**: P2
- **Evidence**: Skills activate via model context matching (implicit)
- **Impact**: Users can't predict what triggers what skill
- **Minimal Fix**: Add activation examples to each SKILL.md
- **Verification**: Manual testing of activation triggers

### GAP-014: No Progress Feedback During Test Run
- **Type**: UX gap
- **Severity**: P2
- **Evidence**: require-green-tests.sh runs tests synchronously with no progress
- **Impact**: Long test runs appear hung
- **Minimal Fix**: Add spinner or progress output
- **Verification**: Run with slow test suite, observe output

## Gap Matrix

| Gap ID | Type | Severity | Fix Complexity | Automated Verification |
|--------|------|----------|----------------|------------------------|
| GAP-001 | Broken wiring | RESOLVED | Medium | Yes |
| GAP-002 | Security | RESOLVED | Low | Yes |
| GAP-003 | Security | RESOLVED | Low | Yes |
| GAP-004 | Security | P1 | Medium | Manual |
| GAP-005 | Verification | RESOLVED | Medium | Yes |
| GAP-006 | Security | P2 | Low | Manual |
| GAP-007 | Security | RESOLVED | Low | Yes |
| GAP-008 | Security | RESOLVED | Low | Yes |
| GAP-009 | Reliability | P2 | Low | Yes |
| GAP-010 | Maintenance | P2 | Medium | Yes |
| GAP-013 | UX | P2 | Low | Manual |
| GAP-014 | UX | P2 | Low | Manual |
