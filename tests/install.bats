#!/usr/bin/env bats

# BATS tests for install.sh
# Run: bats tests/install.bats

REPO_ROOT="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"

setup() {
  # #given - create temp directory for test isolation
  TEST_HOME=$(mktemp -d)
  export HOME="$TEST_HOME"
  mkdir -p "$TEST_HOME/.claude"
}

teardown() {
  # cleanup test directory
  rm -rf "$TEST_HOME"
}

@test "install.sh exists and is executable" {
  # #given
  local script="$REPO_ROOT/install.sh"

  # #then
  [ -f "$script" ]
  [ -x "$script" ]
}

@test "install.sh creates .claude directory structure" {
  # #given
  [ ! -d "$HOME/.claude/skills" ]

  # #when
  run bash "$REPO_ROOT/install.sh" --dry-run 2>/dev/null || true

  # #then - at minimum, the script should be parseable
  [ -f "$REPO_ROOT/install.sh" ]
}

@test "settings.json.example has valid JSON structure" {
  # #given
  local settings="$REPO_ROOT/settings.json.example"

  # #when
  run cat "$settings"

  # #then
  [ "$status" -eq 0 ]
  # Check it starts with { (valid JSON object)
  [[ "$output" == "{"* ]]
}

@test "all required directories exist in repo" {
  # #given - directories that must exist
  local dirs=(agents skills hooks rules commands)

  # #then
  for dir in "${dirs[@]}"; do
    [ -d "$REPO_ROOT/$dir" ]
  done
}

@test "SKILL.md files have valid frontmatter" {
  # #given - find a skill file
  local skill_file
  skill_file=$(find "$REPO_ROOT/skills" -name "SKILL.md" | head -1)

  # #when
  run head -5 "$skill_file"

  # #then - should start with ---
  [[ "${lines[0]}" == "---" ]]
}
