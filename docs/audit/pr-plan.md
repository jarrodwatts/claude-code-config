# PR Plan

**Generated**: 2026-01-12

## Status (as of this audit)

- **RESOLVED**: Quick install works (`install.sh` exists).
- **RESOLVED**: `hooks/workflows/require-green-tests.sh` hardened:
  - Validates `WORKFLOWS_TEST_CMD` / `SUPERPOWERS_TEST_CMD` (rejects unsafe / non-test commands)
  - No longer `source`s the state file (parses expected keys)
  - Uses `umask 077` for state/output files
  - Truncates console output by default (`WORKFLOWS_TEST_MAX_OUTPUT_LINES`, default 200)

## Remaining Recommended PRs

### PR 1 (P1): Add CI validation for this repo

- **Goal**: Prevent regressions in wiring/structure/docs claims.
- **Changes**:
  - Add a GitHub Actions workflow that runs:
    - `bash tests/structure_test.sh`
    - `python3 tests/schema_test.py`
- **Notes**: The previous “scripts/ci/*” harness referenced in older audit docs is not present; the repo’s current test harness lives under `tests/`.

### PR 2 (P1/P2): Further hardening (optional)

- Add locking/atomicity around test-cache reads/writes to avoid TOCTOU issues.
- Consider reducing sensitive output further (pattern filtering or opt-in full output).
- Consider a user-facing warning for missing `jq` in `hooks/todo-enforcer.sh` (currently logs and allows exit).
