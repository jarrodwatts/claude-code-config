#!/usr/bin/env bash
#
# Structure tests - Verify all required files exist
#
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FAILURES=0

assert_exists() {
  if [[ ! -e "$REPO_ROOT/$1" ]]; then
    echo "FAIL: Missing $1"
    ((FAILURES++))
  else
    echo "PASS: $1 exists"
  fi
}

assert_dir_exists() {
  if [[ ! -d "$REPO_ROOT/$1" ]]; then
    echo "FAIL: Missing directory $1"
    ((FAILURES++))
  else
    echo "PASS: $1/ exists"
  fi
}

echo "=== Structure Tests ==="
echo ""

# P0: Critical missing files
echo "--- Core Files ---"
assert_exists "install.sh"
assert_exists "settings.json.example"
assert_exists "CLAUDE.md"
assert_exists "README.md"
assert_exists "INSTALL.md"

echo ""
echo "--- Delegator Prompts ---"
assert_exists "prompts/delegator/architect.md"
assert_exists "prompts/delegator/plan-reviewer.md"
assert_exists "prompts/delegator/scope-analyst.md"
assert_exists "prompts/delegator/code-reviewer.md"
assert_exists "prompts/delegator/security-analyst.md"

echo ""
echo "--- Delegator Config ---"
assert_exists "config/delegator/mcp-servers.example.json"
assert_exists "config/delegator/providers.json"
assert_exists "config/delegator/experts.json"

echo ""
echo "--- Directories ---"
assert_dir_exists "docs/solutions"
assert_dir_exists "agents"
assert_dir_exists "agents/review"
assert_dir_exists "skills"
assert_dir_exists "hooks"
assert_dir_exists "rules"
assert_dir_exists "commands"

echo ""
echo "--- Oracle Agent ---"
assert_exists "agents/oracle.md"

echo ""
echo "=== Count Verification ==="

SKILL_COUNT=$(find "$REPO_ROOT/skills" -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ')
AGENT_COUNT=$(find "$REPO_ROOT/agents" -name "*.md" ! -name "index.md" 2>/dev/null | wc -l | tr -d ' ')
HOOK_COUNT=$(find "$REPO_ROOT/hooks" -type f \( -name "*.py" -o -name "*.sh" \) 2>/dev/null | wc -l | tr -d ' ')
RULE_COUNT=$(find "$REPO_ROOT/rules" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')

echo "Skills: $SKILL_COUNT (expected 18)"
echo "Agents: $AGENT_COUNT (expected 19)"
echo "Hooks: $HOOK_COUNT (expected 5)"
echo "Rules: $RULE_COUNT (expected 8)"

[[ "$SKILL_COUNT" -eq 18 ]] || { echo "FAIL: Skills count $SKILL_COUNT != 18"; ((FAILURES++)); }
[[ "$AGENT_COUNT" -eq 19 ]] || { echo "FAIL: Agents count $AGENT_COUNT != 19"; ((FAILURES++)); }
[[ "$HOOK_COUNT" -eq 5 ]] || { echo "FAIL: Hooks count $HOOK_COUNT != 5"; ((FAILURES++)); }
[[ "$RULE_COUNT" -eq 8 ]] || { echo "FAIL: Rules count $RULE_COUNT != 8"; ((FAILURES++)); }

echo ""
echo "=== Summary ==="
if [[ $FAILURES -gt 0 ]]; then
  echo "FAILED: $FAILURES assertions"
  exit 1
else
  echo "ALL PASSED"
  exit 0
fi
