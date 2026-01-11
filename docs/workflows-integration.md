# Workflows Integration (Jarrod Config)

This repo vendors a curated set of Workflows skills and wires them into Jarrod’s lightweight Claude Code setup. The goal: deterministic routing, minimal redundancy, and a single default executor.

## Installed Skills (under `skills/`)
- using-workflows (discipline/reminder)
- brainstorming
- writing-plans (writes `plans/{slug}.md`)
- executing-plans (default executor)
- subagent-driven-development (only for big/parallel work)
- dispatching-parallel-agents (explicit parallelization)
- test-driven-development
- systematic-debugging
- verification-before-completion
- requesting-code-review
- receiving-code-review
- finishing-a-development-branch
- using-git-worktrees
- writing-skills

Kept from Jarrod: planning-with-files (persistence), react-useeffect (React hygiene).

## Routing Order
using-workflows → brainstorming → writing-plans → planning-with-files → executing-plans → subagent-driven-development (parallel) → dispatching-parallel-agents (explicit) → systematic-debugging → test-driven-development → verification-before-completion → requesting-code-review → receiving-code-review → finishing-a-development-branch → using-git-worktrees → writing-skills → react-useeffect (file-scoped).

Rules:
- Only one executor: use executing-plans unless the plan has >6 tasks or “parallel/agents/workstreams” is explicit, then use subagent-driven-development.
- writing-plans must write to `plans/{slug}.md`; planning-with-files owns persistence/updates to the same file and `notes.md`.
- Tight descriptions reduce accidental triggers; model invocation stays enabled.
- Error routing: failing tests → test-driven-development; lint/typecheck failures → verification-before-completion; exceptions/tool/CI errors → systematic-debugging; plan gaps/unclear next step → writing-plans then executing-plans; design uncertainty → brainstorming. After resolution, return to executing-plans and continue.

## Commands (optional entry points)
- `commands/workflows/brainstorm.md` → run brainstorming loop.
- `commands/workflows/plan.md` → create/update `plans/{slug}.md` with verification.
- `commands/workflows/work.md` → walk tasks, update plan, run checks.
- `commands/workflows/review.md` → multi-agent review with TodoWrite findings.
- `commands/workflows/compound.md` → capture solutions in `docs/solutions/`.

## Stop Hook: Require Green Tests
- Hook script: `hooks/workflows/require-green-tests.sh` (wired in `settings.json`).
- Behavior: on Stop, reuse the last green test run if no tracked file changed; otherwise run the deterministic test command and block completion on failure.
- Test command selection: override with `WORKFLOWS_TEST_CMD` (or legacy `SUPERPOWERS_TEST_CMD`); otherwise auto-picks pnpm/yarn/npm based on lockfile.
- State: cached at `.claude/.state/last_tests.env` in the repo root.
- Works alongside existing Stop hook `hooks/todo-enforcer.sh`.

## Hook Wiring (`settings.json`)
- UserPromptSubmit: `hooks/keyword-detector.py`
- PostToolUse (Write|Edit): `hooks/check-comments.py`
- Stop: `hooks/workflows/require-green-tests.sh`, then `hooks/todo-enforcer.sh`

## Worktrees
- Skill installed (`using-git-worktrees`) for those actively using worktrees; purely guidance, no enforcement.

## How to Override
- Test command: set env `WORKFLOWS_TEST_CMD="pnpm test --filter api"` before invoking Stop (legacy `SUPERPOWERS_TEST_CMD` still works).
- Skip heavy suites: narrow the command via the env override; the hook itself stays deterministic.

## Minimal Adoption Path
1) Use `/workflows:plan` (or let auto skills trigger) to create `plans/{slug}.md`.
2) Execute with `executing-plans` (or `/workflows:work`); keep the plan updated.
3) Run `/workflows:review` to generate TodoWrite review items.
4) Use `/workflows:compound` to document solutions.
5) Let the Stop hook enforce green tests before declaring done.
