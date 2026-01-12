---
name: SystematicDebugging
description: Reproduce, narrow, and fix issues methodically. USE WHEN facing errors OR exceptions OR failing commands OR CI failures OR unexplained behavior.
---

# SystematicDebugging

Debug methodically instead of guessing.

## Workflow Routing

| Workflow | Trigger | File |
|----------|---------|------|
| **Debug** | error, exception, "not working", failing test | Inline |

## Process

1. Reproduce: capture exact command/input/output and frequency.
2. Localize: binary search or log to find the smallest failing surface.
3. Form hypotheses; test one at a time.
4. If two hypotheses fail, run a Codex counter-review via `/claude-delegator/task`.
5. Inspect recent changes and configs affecting the area.
6. Confirm fix with the original repro + automated test if possible.
7. If tests missing, branch to `TestDrivenDevelopment` to lock the fix.
8. Record repro steps and fix summary in `plans/{slug}.md`.

## Examples

**Example 1: Test failure**
```
User: "This test is failing with X error"
→ Invokes SystematicDebugging
→ Reproduces, localizes, forms hypothesis
→ Fixes and confirms with repro
```

**Example 2: CI failure**
```
User: "CI is failing but works locally"
→ Investigates environment differences
→ Narrows to specific cause
```
