#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
STATE_DIR="$REPO_ROOT/.claude/.state"
STATE_FILE="$STATE_DIR/last_tests.env"
mkdir -p "$STATE_DIR"

# Pick a deterministic test command. Allow override via env.
pick_test_cmd() {
  if [[ -n "${WORKFLOWS_TEST_CMD-}" ]]; then
    echo "$WORKFLOWS_TEST_CMD"
    return
  fi
  if [[ -n "${SUPERPOWERS_TEST_CMD-}" ]]; then
    echo "$SUPERPOWERS_TEST_CMD"
    return
  fi
  if [[ -f "$REPO_ROOT/pnpm-lock.yaml" ]]; then
    echo "pnpm test"
  elif [[ -f "$REPO_ROOT/yarn.lock" ]]; then
    echo "yarn test"
  elif [[ -f "$REPO_ROOT/package-lock.json" || -f "$REPO_ROOT/npm-shrinkwrap.json" ]]; then
    echo "npm test"
  else
    echo "npm test"
  fi
}

newest_tracked_mtime() {
  if command -v git >/dev/null 2>&1 && git -C "$REPO_ROOT" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    local newest
    newest=$(git -C "$REPO_ROOT" ls-files -z 2>/dev/null | xargs -0 stat -f "%m" 2>/dev/null | sort -n | tail -1)
    echo "${newest:-0}"
  else
    echo "0"
  fi
}

TEST_CMD=$(pick_test_cmd)
LATEST_MTIME=$(newest_tracked_mtime)
PREV_STATUS=""; PREV_CMD=""; PREV_MTIME=0
if [[ -f "$STATE_FILE" ]]; then
  # shellcheck disable=SC1090
  source "$STATE_FILE"
fi

# Fast path: reuse recent green run if unchanged and same command.
if [[ "$PREV_STATUS" == "green" && "$PREV_CMD" == "$TEST_CMD" ]]; then
  if [[ "$PREV_MTIME" -ge "$LATEST_MTIME" ]]; then
    echo "Stop hook: tests already green (cmd: $TEST_CMD)."
    exit 0
  fi
fi

echo "Stop hook: running test command: $TEST_CMD"
set +e
OUTPUT=$(cd "$REPO_ROOT" && bash -lc "$TEST_CMD" 2>&1)
STATUS=$?
set -e
if [[ $STATUS -eq 0 ]]; then
  date -u +"ran_at=%Y-%m-%dT%H:%M:%SZ" > "$STATE_FILE"
  {
    echo "PREV_STATUS=green"
    echo "PREV_CMD=$TEST_CMD"
    echo "PREV_MTIME=$LATEST_MTIME"
  } >> "$STATE_FILE"
  echo "$OUTPUT"
  echo "Stop hook: tests green; allowing completion."
  exit 0
else
  echo "$OUTPUT"
  echo "Stop hook: tests failed (exit $STATUS); blocking completion." >&2
  exit $STATUS
fi
