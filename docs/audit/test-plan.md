# Test Plan

**Generated**: 2026-01-12

## Overview

This repository is a Claude Code configuration repo (not an application). Tests focus on:
1. Structural integrity (required files exist)
2. Content integrity (frontmatter/schema expectations)
3. Wiring completeness (INSTALL.md references resolve; settings template is valid)

## Current Test Harness

### 1) Structure Checks

- **File**: `tests/structure_test.sh`
- **Purpose**: Verify required files/directories exist and component counts match documented expectations
- **Run**:
  ```bash
  bash tests/structure_test.sh
  ```

### 2) Schema & Reference Checks

- **File**: `tests/schema_test.py`
- **Validates**:
  - Agents: `name:`, `description:`, `model:` fields present (skips `agents/**/index.md`)
  - Skills: frontmatter exists with `name:` and `description:`
  - Commands: frontmatter exists with `description:`
  - Config JSON under `config/**` parses
  - `settings.json.example` parses and includes a `hooks` key
  - All `INSTALL.md` install destinations (→ `~/.claude/...`) exist in the repo (excluding `settings.json`)
- **Run**:
  ```bash
  python3 tests/schema_test.py
  ```

## Recommended Automation (Optional)

- Add CI to run:
  - `bash tests/structure_test.sh`
  - `python3 tests/schema_test.py`
