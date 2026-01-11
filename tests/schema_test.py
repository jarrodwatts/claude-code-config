#!/usr/bin/env python3
"""
Schema tests - Validate content structure of config files.
"""

import json
import re
import subprocess
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent
FAILURES = []


def fail(msg: str):
    FAILURES.append(msg)
    print(f"FAIL: {msg}")


def passed(msg: str):
    print(f"PASS: {msg}")


def test_agent_schema():
    """All agents must have name, description, and model fields."""
    print("\n--- Agent Schema ---")
    for agent_file in sorted(REPO_ROOT.glob("agents/**/*.md")):
        if agent_file.name == "index.md":
            continue
        content = agent_file.read_text()
        rel_path = agent_file.relative_to(REPO_ROOT)

        missing = []
        if "name:" not in content:
            missing.append("name:")
        if "description:" not in content:
            missing.append("description:")
        if "model:" not in content:
            missing.append("model:")

        if missing:
            fail(f"{rel_path}: missing {', '.join(missing)}")
        else:
            passed(f"{rel_path}")


def test_skill_schema():
    """All SKILL.md files must have frontmatter with name and description."""
    print("\n--- Skill Schema ---")
    for skill_file in sorted(REPO_ROOT.glob("skills/*/SKILL.md")):
        content = skill_file.read_text()
        rel_path = skill_file.relative_to(REPO_ROOT)

        if not content.startswith("---"):
            fail(f"{rel_path}: missing frontmatter")
            continue

        fm_end = content.find("---", 3)
        if fm_end == -1:
            fail(f"{rel_path}: malformed frontmatter")
            continue

        frontmatter = content[3:fm_end]
        missing = []
        if "name:" not in frontmatter:
            missing.append("name:")
        if "description:" not in frontmatter:
            missing.append("description:")

        if missing:
            fail(f"{rel_path}: missing {', '.join(missing)}")
        else:
            passed(f"{rel_path}")


def test_command_schema():
    """All commands must have frontmatter with description."""
    print("\n--- Command Schema ---")
    for cmd_file in sorted(REPO_ROOT.glob("commands/**/*.md")):
        content = cmd_file.read_text()
        rel_path = cmd_file.relative_to(REPO_ROOT)

        if not content.startswith("---"):
            fail(f"{rel_path}: missing frontmatter")
            continue

        fm_end = content.find("---", 3)
        if fm_end == -1:
            fail(f"{rel_path}: malformed frontmatter")
            continue

        frontmatter = content[3:fm_end]
        if "description:" not in frontmatter:
            fail(f"{rel_path}: missing description:")
        else:
            passed(f"{rel_path}")


def test_json_files_valid():
    """All JSON config files must be valid JSON."""
    print("\n--- JSON Validation ---")
    for json_file in sorted(REPO_ROOT.glob("config/**/*.json")):
        rel_path = json_file.relative_to(REPO_ROOT)
        try:
            content = json_file.read_text()
            json.loads(content)
            passed(f"{rel_path}")
        except json.JSONDecodeError as e:
            fail(f"{rel_path}: invalid JSON - {e}")


def test_settings_json_example():
    """settings.json.example must be valid JSON with hooks."""
    print("\n--- Settings Template ---")
    settings_file = REPO_ROOT / "settings.json.example"
    if not settings_file.exists():
        fail("settings.json.example: missing")
        return

    try:
        content = json.loads(settings_file.read_text())
        if "hooks" not in content:
            fail("settings.json.example: missing 'hooks' key")
        else:
            passed("settings.json.example: valid with hooks")
    except json.JSONDecodeError as e:
        fail(f"settings.json.example: invalid JSON - {e}")


def test_install_references_exist():
    """All files referenced in INSTALL.md must exist."""
    print("\n--- INSTALL.md References ---")
    install_md = (REPO_ROOT / "INSTALL.md").read_text()

    # Extract all → ~/.claude/... paths
    pattern = r"→ ~/\.claude/([^\s]+)"
    missing = []
    checked = 0

    for match in re.finditer(pattern, install_md):
        rel_path = match.group(1)
        # Skip settings.json (user-specific)
        if rel_path.startswith("settings.json"):
            continue
        # Skip CLAUDE.md (it's at repo root, not in subdirectory)
        if rel_path == "CLAUDE.md":
            if (REPO_ROOT / "CLAUDE.md").exists():
                checked += 1
            else:
                missing.append(rel_path)
            continue

        if not (REPO_ROOT / rel_path).exists():
            missing.append(rel_path)
        else:
            checked += 1

    if missing:
        for m in missing[:5]:  # Show first 5
            fail(f"INSTALL.md references missing: {m}")
        if len(missing) > 5:
            fail(f"...and {len(missing) - 5} more missing files")
    else:
        passed(f"INSTALL.md: all {checked} file references exist")


def main():
    print("=== Schema Tests ===")

    test_agent_schema()
    test_skill_schema()
    test_command_schema()
    test_json_files_valid()
    test_settings_json_example()
    test_install_references_exist()

    print("\n=== Summary ===")
    if FAILURES:
        print(f"FAILED: {len(FAILURES)} assertions")
        return 1
    else:
        print("ALL PASSED")
        return 0


if __name__ == "__main__":
    sys.exit(main())
