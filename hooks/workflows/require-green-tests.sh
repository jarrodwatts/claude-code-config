#!/usr/bin/env bash
set -euo pipefail

umask 077

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
STATE_DIR="$REPO_ROOT/.claude/.state"
STATE_FILE="$STATE_DIR/last_tests.env"
mkdir -p "$STATE_DIR"

# Pick a deterministic test command. Allow override via env (safely).
is_safe_override_value() {
  local value="$1"

  # Reject shell metacharacters / expansions / quoting / globs / control chars.
  if [[ "$value" == *$'\n'* || "$value" == *$'\r'* || "$value" == *$'\t'* ]]; then
    return 1
  fi
  if [[ "$value" =~ [\;\&\|\<\>\$\`\\\'\"\(\)\{\}\[\]\*\?\#\!] ]]; then
    return 1
  fi

  return 0
}

is_allowed_test_cmd() {
  local cmd="$1"
  local -a tokens=()
  read -r -a tokens <<<"$cmd"

  ((${#tokens[@]} >= 1)) || return 1

  case "${tokens[0]}" in
    npm)
      [[ "${tokens[1]-}" == "test" ]] && return 0
      [[ "${tokens[1]-}" == "run" && "${tokens[2]-}" == test* ]] && return 0
      ;;
    pnpm)
      [[ "${tokens[1]-}" == "test" ]] && return 0
      [[ "${tokens[1]-}" == "run" && "${tokens[2]-}" == test* ]] && return 0
      ;;
    yarn)
      [[ "${tokens[1]-}" == "test" ]] && return 0
      [[ "${tokens[1]-}" == "run" && "${tokens[2]-}" == test* ]] && return 0
      ;;
    bun)
      [[ "${tokens[1]-}" == "test" ]] && return 0
      ;;
    pytest)
      return 0
      ;;
    python | python3)
      [[ "${tokens[1]-}" == "-m" && "${tokens[2]-}" == "pytest" ]] && return 0
      ;;
    go)
      [[ "${tokens[1]-}" == "test" ]] && return 0
      ;;
    cargo)
      [[ "${tokens[1]-}" == "test" ]] && return 0
      ;;
    mix)
      [[ "${tokens[1]-}" == "test" ]] && return 0
      ;;
    bundle)
      [[ "${tokens[1]-}" == "exec" && "${tokens[2]-}" == "rspec" ]] && return 0
      ;;
    make | just)
      [[ "${tokens[1]-}" == test* ]] && return 0
      ;;
  esac

  return 1
}

validated_override_cmd() {
  local name="$1"
  local value="${2-}"
  [[ -n "$value" ]] || return 1

  if ! is_safe_override_value "$value"; then
    echo "Stop hook: rejecting $name (unsafe characters); using auto-detection." >&2
    return 1
  fi

  if ! is_allowed_test_cmd "$value"; then
    echo "Stop hook: rejecting $name (not a recognized test command); using auto-detection." >&2
    return 1
  fi

  echo "$value"
  return 0
}

pick_test_cmd() {
  local cmd=""
  if cmd="$(validated_override_cmd "WORKFLOWS_TEST_CMD" "${WORKFLOWS_TEST_CMD-}")"; then
    echo "$cmd"
    return
  fi
  if cmd="$(validated_override_cmd "SUPERPOWERS_TEST_CMD" "${SUPERPOWERS_TEST_CMD-}")"; then
    echo "$cmd"
    return
  fi
  if [[ -f "$REPO_ROOT/pnpm-lock.yaml" ]]; then
    echo "pnpm test"
  elif [[ -f "$REPO_ROOT/yarn.lock" ]]; then
    echo "yarn test"
  elif [[ -f "$REPO_ROOT/package-lock.json" || -f "$REPO_ROOT/npm-shrinkwrap.json" ]]; then
    echo "npm test"
  else
    # No lock file found - check if package.json exists at all
    if [[ -f "$REPO_ROOT/package.json" ]]; then
      echo "npm test"
    else
      echo "skip"
    fi
  fi
}

newest_tracked_mtime() {
  if command -v git >/dev/null 2>&1 && git -C "$REPO_ROOT" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    local newest
    if [[ "$(uname -s)" == "Darwin" ]]; then
      newest=$(git -C "$REPO_ROOT" ls-files -z 2>/dev/null | xargs -0 stat -f "%m" 2>/dev/null | sort -n | tail -1)
    else
      newest=$(git -C "$REPO_ROOT" ls-files -z 2>/dev/null | xargs -0 stat -c "%Y" 2>/dev/null | sort -n | tail -1)
    fi
    echo "${newest:-0}"
  else
    echo "0"
  fi
}

sha256() {
  local input="$1"
  if command -v shasum >/dev/null 2>&1; then
    printf '%s' "$input" | shasum -a 256 | awk '{print $1}'
    return 0
  fi
  if command -v sha256sum >/dev/null 2>&1; then
    printf '%s' "$input" | sha256sum | awk '{print $1}'
    return 0
  fi
  return 1
}

load_state() {
  PREV_STATUS=""
  PREV_CMD_HASH=""
  PREV_MTIME=0

  [[ -f "$STATE_FILE" ]] || return 0

  local line key value
  while IFS= read -r line || [[ -n "$line" ]]; do
    [[ -z "$line" ]] && continue
    IFS='=' read -r key value <<<"$line"
    case "$key" in
      PREV_STATUS) PREV_STATUS="$value" ;;
      PREV_CMD_HASH) PREV_CMD_HASH="$value" ;;
      PREV_MTIME) PREV_MTIME="$value" ;;
    esac
  done <"$STATE_FILE"

  [[ "$PREV_STATUS" == "green" ]] || PREV_STATUS=""
  [[ "$PREV_MTIME" =~ ^[0-9]+$ ]] || PREV_MTIME=0
  [[ "$PREV_CMD_HASH" =~ ^[0-9a-fA-F]{64}$ ]] || PREV_CMD_HASH=""
}

write_state_green() {
  local cmd_hash="$1"
  local mtime="$2"
  local tmp

  tmp="$(mktemp "$STATE_DIR/last_tests.env.tmp.XXXXXX")"
  {
    date -u +"ran_at=%Y-%m-%dT%H:%M:%SZ"
    echo "PREV_STATUS=green"
    [[ -n "$cmd_hash" ]] && echo "PREV_CMD_HASH=$cmd_hash"
    echo "PREV_MTIME=$mtime"
  } >"$tmp"
  mv "$tmp" "$STATE_FILE"
}

as_bash_lc_cmd() {
  local cmd="$1"
  local -a tokens=()
  read -r -a tokens <<<"$cmd"
  ((${#tokens[@]} >= 1)) || return 1

  local quoted=""
  local t
  for t in "${tokens[@]}"; do
    quoted+=" $(printf '%q' "$t")"
  done
  echo "${quoted# }"
}

print_test_output() {
  local output_file="$1"
  local max_lines="${WORKFLOWS_TEST_MAX_OUTPUT_LINES:-200}"

  if [[ -z "$max_lines" || ! "$max_lines" =~ ^[0-9]+$ ]]; then
    max_lines=200
  fi

  local total_lines
  total_lines=$(wc -l <"$output_file" | tr -d ' ')
  if [[ -n "$total_lines" && "$total_lines" =~ ^[0-9]+$ && "$total_lines" -gt "$max_lines" ]]; then
    echo "Stop hook: test output truncated (showing last $max_lines of $total_lines lines)."
    tail -n "$max_lines" "$output_file"
  else
    cat "$output_file"
  fi
}

TEST_CMD=$(pick_test_cmd)
if [[ "$TEST_CMD" == "skip" ]]; then
  echo "Stop hook: no test infrastructure detected; skipping."
  exit 0
fi
LATEST_MTIME=$(newest_tracked_mtime)

CMD_HASH=""
if CMD_HASH="$(sha256 "$TEST_CMD" 2>/dev/null)"; then
  :
else
  CMD_HASH=""
fi

load_state

# Fast path: reuse recent green run if unchanged and same command.
if [[ "$PREV_STATUS" == "green" && -n "$CMD_HASH" && "$PREV_CMD_HASH" == "$CMD_HASH" && "$PREV_MTIME" -ge "$LATEST_MTIME" ]]; then
  echo "Stop hook: tests already green (cmd: $TEST_CMD)."
  exit 0
fi

echo "Stop hook: running test command: $TEST_CMD"
RUN_CMD="$(as_bash_lc_cmd "$TEST_CMD")"
OUTPUT_FILE="$(mktemp "$STATE_DIR/test-output.XXXXXX")"
cleanup() { rm -f "$OUTPUT_FILE"; }
trap cleanup EXIT

set +e
cd "$REPO_ROOT" && bash -lc "$RUN_CMD" >"$OUTPUT_FILE" 2>&1
STATUS=$?
set -e
if [[ $STATUS -eq 0 ]]; then
  write_state_green "$CMD_HASH" "$LATEST_MTIME"
  print_test_output "$OUTPUT_FILE"
  echo "Stop hook: tests green; allowing completion."
  exit 0
else
  print_test_output "$OUTPUT_FILE"
  echo "Stop hook: tests failed (exit $STATUS); blocking completion." >&2
  exit $STATUS
fi
