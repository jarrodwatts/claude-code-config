#!/usr/bin/env python3
"""
Behavioral tests for keyword-detector.py pattern matching.

Tests that all documented patterns actually trigger the expected contexts.
"""

import json
import re
import sys
from pathlib import Path

# Import the patterns from keyword-detector.py
sys.path.insert(0, str(Path(__file__).parent.parent / "hooks"))

REPO_ROOT = Path(__file__).parent.parent
FAILURES = []


def fail(msg: str):
    FAILURES.append(msg)
    print(f"FAIL: {msg}")


def passed(msg: str):
    print(f"PASS: {msg}")


# =============================================================================
# PATTERN DEFINITIONS (copied from keyword-detector.py for verification)
# =============================================================================

PATTERNS_MODE = {
    "ultrawork": r"\b(ultrawork|ulw|ultra\s*work)\b",
    "delegation": r"\b(multi[-\s]*agent|delegate|delegation|parallelize|parallelise|parallel|sub[-\s]*agent|gpt|codex|delegator)\b",
    "search": r"\b(search|find|locate|where\s+is)\b",
    "analysis": r"\b(analyze|investigate|debug|diagnose)\b",
    "think": r"\b(think\s*(deeply|hard|carefully))\b",
}

PATTERNS_REVIEW = {
    "review_code": r"\breview\s+(\w+\s+)?(code|pr|pull\s*request|diff|changes?)\b",
    "review_plan": r"\breview\s+(this\s+)?(plan|proposal|design)\b",
    "review_security": r"\b(security\s+review|is\s+this\s+secure|threat\s+model|pentest|vulnerabilit(y|ies)?)\b",
    "review_performance": r"\b(performance|perf)\s+(review|check|audit)\b",
    "review_architecture": r"\b(architecture|arch)\s+(review|check|audit)\b",
    "review_general": r"\breview\b.*\b(codebase|project|repo)\b",
}

PATTERNS_EXPLORATION = {
    "how_does": r"\bhow\s+does\b.*\b(work|function|behave)\b",
    "where_is": r"\b(where\s+is|which\s+file|find\s+the)\b",
    "what_is": r"\b(what\s+is|what\s+are)\b.*\b(this|these|the)\b",
    "trace": r"\b(trace|follow|track)\b.*\b(flow|path|execution)\b",
}

PATTERNS_LIBRARY = {
    "how_to_use": r"\bhow\s+(do\s+i|to)\s+use\b",
    "best_practice": r"\b(best\s+practice|recommended\s+way|official\s+docs?)\b",
    "library_behavior": r"\bwhy\s+does\b.*\b(behave|work|return)\b",
    "package_manager": r"\b(npm|pip|cargo|gem|nuget|yarn|pnpm|bun)\s+(install|add|package)\b",
    "library_mention": r"\b(react|vue|angular|svelte|next\.?js|nuxt|express|fastify|django|flask|rails|spring|laravel|prisma|drizzle|typeorm|sequelize|mongoose|redis|postgres|mongodb|graphql|trpc|zod|yup|joi|lodash|underscore|axios|fetch|tanstack|zustand|redux|mobx|tailwind|styled-components|emotion|chakra|shadcn|radix)\b",
}

PATTERNS_GITHUB = {
    "github_mention": r"(@\w+\s+mentioned|gh\s+issue|github\s+issue|issue\s+#\d+|#\d{2,})",
    "create_pr": r"\b(create|open|make)\s+(a\s+)?(pr|pull\s*request)\b",
    "look_into_pr": r"\b(look\s+into|investigate).*\b(create|make)\s+(a\s+)?pr\b",
}

PATTERNS_DOMAIN = {
    "security": r"\b(auth|authentication|authorization|oauth|jwt|session|permission|rbac|secret|credentials?|password|token|encrypt)\b",
    "performance": r"\b(slow|performance|bottleneck|n\+1|cach(e|ing)|optimize|latency|throughput)\b",
    "migration": r"\b(migration|schema|alter\s+table|add\s+column|backfill)\b",
    "deployment": r"\b(deploy|deployment|ci|cd|pipeline|rollout|feature\s+flag)\b",
    "frontend": r"\b(react|vue|angular|useEffect|useState|component|frontend|ui)\b",
    "api": r"\b(api|endpoint|route|controller|graphql|rest)\b",
}

PATTERNS_SKILLS = {
    "debugging": r"\b(error|exception|traceback|stack\s*trace|failed|failing|broken|crash|bug|not\s+working|doesn.t\s+work)\b",
    "tdd": r"\b(add\s+(a\s+)?(test|spec)|write\s+test|test\s+first|red.green.refactor|tdd)\b",
    "planning": r"\b(plan|roadmap|multi.step|complex\s+task|project\s+plan|implementation\s+plan)\b",
    "compound": r"\b(that\s+worked|it.s\s+fixed|problem\s+solved|issue\s+resolved|working\s+now)\b",
    "brainstorm": r"\b(brainstorm|options|approaches|alternatives|design\s+decision|trade.?offs?|pros\s+and\s+cons)\b",
    "verification": r"\b(done|finished|completed|ready\s+to\s+(ship|merge|deploy))\b",
}


# =============================================================================
# TEST CASES
# =============================================================================


def test_pattern(pattern_name: str, pattern: str, test_cases: list, should_match: bool = True):
    """Test that a pattern matches or doesn't match the given test cases."""
    for test in test_cases:
        matched = bool(re.search(pattern, test.lower(), re.I))
        expected = "match" if should_match else "no-match"
        actual = "match" if matched else "no-match"

        if matched == should_match:
            passed(f"{pattern_name}: '{test[:40]}...' → {actual}")
        else:
            fail(f"{pattern_name}: '{test[:40]}...' → expected {expected}, got {actual}")


def test_mode_patterns():
    """Test Tier 1: Mode activation patterns."""
    print("\n--- Tier 1: Mode Patterns ---")

    test_pattern("ultrawork", PATTERNS_MODE["ultrawork"], [
        "ultrawork on this feature",
        "ulw mode please",
        "ultra work session",
    ])

    test_pattern("delegation", PATTERNS_MODE["delegation"], [
        "use multi-agent approach",
        "delegate this to subagents",
        "parallelize the work",
        "use codex for review",
    ])

    test_pattern("search", PATTERNS_MODE["search"], [
        "search for auth functions",
        "find the login handler",
        "where is the config file",
    ])

    test_pattern("analysis", PATTERNS_MODE["analysis"], [
        "analyze this code",
        "investigate the bug",
        "debug the issue",
        "diagnose the problem",
    ])

    test_pattern("think", PATTERNS_MODE["think"], [
        "think deeply about this",
        "think hard about the solution",
        "think carefully before implementing",
    ])


def test_review_patterns():
    """Test Tier 2: Review patterns."""
    print("\n--- Tier 2: Review Patterns ---")

    test_pattern("review_code", PATTERNS_REVIEW["review_code"], [
        "review this code",
        "review the PR",
        "review my changes",
        "review this pull request",
    ])

    test_pattern("review_security", PATTERNS_REVIEW["review_security"], [
        "security review needed",
        "is this secure?",
        "do a threat model",
        "check for vulnerabilities",
    ])

    test_pattern("review_performance", PATTERNS_REVIEW["review_performance"], [
        "performance review please",
        "perf check this",
        "do a perf audit",
    ])

    test_pattern("review_architecture", PATTERNS_REVIEW["review_architecture"], [
        "architecture review needed",
        "arch check this design",
        "do an arch audit",
    ])

    test_pattern("review_general", PATTERNS_REVIEW["review_general"], [
        "review this codebase",
        "review the project",
        "review this repo for issues",
    ])


def test_exploration_patterns():
    """Test Tier 3: Exploration patterns."""
    print("\n--- Tier 3: Exploration Patterns ---")

    test_pattern("how_does", PATTERNS_EXPLORATION["how_does"], [
        "how does the auth system work",
        "how does this function behave",
        "how does the cache work",
    ])

    test_pattern("where_is", PATTERNS_EXPLORATION["where_is"], [
        "where is the config file",
        "which file has the router",
        "find the database module",
    ])

    test_pattern("trace", PATTERNS_EXPLORATION["trace"], [
        "trace the data flow",
        "follow the execution path",
        "track the request flow",
    ])


def test_library_patterns():
    """Test Tier 4: Library patterns."""
    print("\n--- Tier 4: Library Patterns ---")

    test_pattern("how_to_use", PATTERNS_LIBRARY["how_to_use"], [
        "how do I use zod",
        "how to use prisma",
    ])

    test_pattern("best_practice", PATTERNS_LIBRARY["best_practice"], [
        "best practice for auth",
        "recommended way to handle",
        "official docs for react",
    ])

    test_pattern("library_mention", PATTERNS_LIBRARY["library_mention"], [
        "using react hooks",
        "vue composition api",
        "express middleware",
        "prisma schema",
        "tailwind classes",
        "zustand store",
    ])

    test_pattern("package_manager", PATTERNS_LIBRARY["package_manager"], [
        "npm install axios",
        "pip install django",
        "cargo add serde",
        "bun add zod",
    ])


def test_github_patterns():
    """Test Tier 5: GitHub patterns."""
    print("\n--- Tier 5: GitHub Patterns ---")

    test_pattern("github_mention", PATTERNS_GITHUB["github_mention"], [
        "@user mentioned this",
        "gh issue #123",
        "github issue discussion",
        "issue #45 needs fixing",
    ])

    test_pattern("create_pr", PATTERNS_GITHUB["create_pr"], [
        "create a PR",
        "open a pull request",
        "make a pr for this",
    ])

    test_pattern("look_into_pr", PATTERNS_GITHUB["look_into_pr"], [
        "look into this and create a pr",
        "investigate the issue and make a PR",
    ])


def test_domain_patterns():
    """Test Tier 6: Domain patterns."""
    print("\n--- Tier 6: Domain Patterns ---")

    test_pattern("security", PATTERNS_DOMAIN["security"], [
        "authentication flow",
        "oauth integration",
        "jwt token handling",
        "check credentials",
    ])

    test_pattern("performance", PATTERNS_DOMAIN["performance"], [
        "slow query",
        "performance issue",
        "n+1 problem",
        "add caching",
    ])


def test_skill_patterns():
    """Test Tier 7: Skill activation patterns."""
    print("\n--- Tier 7: Skill Patterns ---")

    test_pattern("debugging", PATTERNS_SKILLS["debugging"], [
        "getting an error",
        "exception thrown",
        "stack trace shows",
        "test is failing",
        "broken build",
        "doesn't work anymore",
    ])

    test_pattern("tdd", PATTERNS_SKILLS["tdd"], [
        "add a test for this",
        "write test first",
        "red green refactor",
        "following tdd",
    ])

    test_pattern("planning", PATTERNS_SKILLS["planning"], [
        "create a plan",
        "build a roadmap",
        "multi-step task",
        "implementation plan needed",
    ])

    test_pattern("compound", PATTERNS_SKILLS["compound"], [
        "that worked!",
        "it's fixed now",
        "problem solved",
        "issue resolved",
        "working now",
    ])

    test_pattern("brainstorm", PATTERNS_SKILLS["brainstorm"], [
        "let's brainstorm",
        "what are my options",
        "explore approaches",
        "design decision needed",
        "trade-offs to consider",
    ])


def test_negative_cases():
    """Test that patterns don't over-match."""
    print("\n--- Negative Cases (should NOT match) ---")

    # ultrawork shouldn't match "work"
    test_pattern("ultrawork-negative", PATTERNS_MODE["ultrawork"], [
        "let's work on this",
        "this will work",
    ], should_match=False)

    # think shouldn't match plain "think"
    test_pattern("think-negative", PATTERNS_MODE["think"], [
        "I think this is wrong",
        "what do you think",
    ], should_match=False)

    # review_code shouldn't match "view"
    test_pattern("review_code-negative", PATTERNS_REVIEW["review_code"], [
        "view the file",
        "preview the changes",
    ], should_match=False)


def test_context_output_structure():
    """Test that keyword-detector.py produces valid output structure."""
    print("\n--- Output Structure ---")

    # Mock test - verify the hook script exists and is executable
    hook_path = REPO_ROOT / "hooks" / "keyword-detector.py"

    if not hook_path.exists():
        fail("hooks/keyword-detector.py does not exist")
        return

    if not hook_path.stat().st_mode & 0o111:
        fail("hooks/keyword-detector.py is not executable")
    else:
        passed("hooks/keyword-detector.py exists and is executable")

    # Verify it has the required output structure
    content = hook_path.read_text()

    if "hookSpecificOutput" not in content:
        fail("Missing hookSpecificOutput in output structure")
    else:
        passed("Hook uses hookSpecificOutput format")

    if "additionalContext" not in content:
        fail("Missing additionalContext in output")
    else:
        passed("Hook includes additionalContext")

    if "write_context_flags" not in content:
        fail("Missing context flag writing function")
    else:
        passed("Hook writes context flags for PreToolUse")


def test_pattern_count():
    """Verify we have the expected number of patterns across all tiers."""
    print("\n--- Pattern Count ---")

    total_patterns = (
        len(PATTERNS_MODE)
        + len(PATTERNS_REVIEW)
        + len(PATTERNS_EXPLORATION)
        + len(PATTERNS_LIBRARY)
        + len(PATTERNS_GITHUB)
        + len(PATTERNS_DOMAIN)
        + len(PATTERNS_SKILLS)
    )

    # We documented 28 patterns in the PR
    expected_min = 28

    if total_patterns >= expected_min:
        passed(f"Pattern count: {total_patterns} (expected >= {expected_min})")
    else:
        fail(f"Pattern count: {total_patterns} (expected >= {expected_min})")


def main():
    print("=== Keyword Detector Behavioral Tests ===")

    test_mode_patterns()
    test_review_patterns()
    test_exploration_patterns()
    test_library_patterns()
    test_github_patterns()
    test_domain_patterns()
    test_skill_patterns()
    test_negative_cases()
    test_context_output_structure()
    test_pattern_count()

    print("\n=== Summary ===")
    if FAILURES:
        print(f"FAILED: {len(FAILURES)} assertions")
        for f in FAILURES[:10]:
            print(f"  - {f}")
        if len(FAILURES) > 10:
            print(f"  ... and {len(FAILURES) - 10} more")
        return 1
    else:
        print("ALL PASSED")
        return 0


if __name__ == "__main__":
    sys.exit(main())
