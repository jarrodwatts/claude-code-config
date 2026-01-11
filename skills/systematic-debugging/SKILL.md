---
name: workflows-systematic-debugging
description: Reproduce, narrow, and fix issues methodically instead of guessing; triggers on exceptions, failing commands, CI/test errors, or unexplained behavior.
---

# Systematic Debugging

Use when facing errors, failures, or unclear behavior.

Steps:
1. Reproduce: capture exact command/input/output and frequency.
2. Localize: binary search or log to find the smallest failing surface.
3. Form hypotheses; test one at a time.
4. Inspect recent changes and configs affecting the area.
5. Confirm fix with the original repro + an automated test if possible.
6. If tests are missing, branch to `test-driven-development` to lock the fix.
7. Record repro steps and fix summary in `plans/{slug}.md`; then return to the active executor (`executing-plans`).
