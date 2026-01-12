# Claude Code Config - Capability Test Plan

**Purpose**: Test Claude's ability to correctly use all skills, agents, hooks, rules, and workflows in this config.

**How to Use**: Run each scenario and verify the expected components activate.

---

## Test Matrix Summary

| Category | Count | Coverage |
|----------|-------|----------|
| Skills | 18 | All tested |
| Agents | 20 | All tested |
| Hooks | 4 | All tested |
| Rules | 8 | All tested |
| Commands | 9 | All tested |

---

## 1. Skills (18)

### Planning & Structure

| # | Skill | Test Scenario | Expected Behavior | Verify |
|---|-------|---------------|-------------------|--------|
| 1 | `planning-with-files` | "Plan a user authentication feature for this repo" | Creates `plans/user-auth.md` with structured tasks | File exists with sections |
| 2 | `writing-plans` | "Write a detailed plan for adding WebSocket support" | Generates plan with risk assessment, phases, verifiable tasks | Plan has all sections |
| 3 | `executing-plans` | "Execute the plan in plans/test-plan.md" | Reads plan, creates todos, updates status in file | Status markers update |
| 4 | `brainstorming` | "Brainstorm approaches for caching in this system" | Generates 3+ options with tradeoffs before committing | Multiple options presented |

### Development Patterns

| # | Skill | Test Scenario | Expected Behavior | Verify |
|---|-------|---------------|-------------------|--------|
| 5 | `test-driven-development` | "Add a function to validate email with TDD" | Red→Green→Refactor cycle, test written first | Test before implementation |
| 6 | `systematic-debugging` | "Debug: the install.sh script fails on fresh systems" | Reproduce→Localize→Fix methodology | Structured debug process |
| 7 | `subagent-driven-development` | "Implement logging, metrics, and alerting systems" | Recognizes parallel opportunity, spawns multiple agents | Multiple Task tool calls |
| 8 | `dispatching-parallel-agents` | "Run 3 different code review perspectives in parallel" | Parallel Task invocations, not sequential | Single message, multiple agents |

### Code Review

| # | Skill | Test Scenario | Expected Behavior | Verify |
|---|-------|---------------|-------------------|--------|
| 9 | `requesting-code-review` | "Request a code review for hooks/keyword-detector.py" | Summarizes changes, identifies risk areas, requests review | Proper review request format |
| 10 | `receiving-code-review` | (After review) "Address the review feedback" | Processes each point, makes changes, responds | All points addressed |

### Git & Workflow

| # | Skill | Test Scenario | Expected Behavior | Verify |
|---|-------|---------------|-------------------|--------|
| 11 | `finishing-a-development-branch` | "I'm done with this feature branch, help me finish" | Checklist: tests, lint, PR prep, cleanup | All steps covered |
| 12 | `using-git-worktrees` | "Set up a worktree for parallel feature development" | Explains worktree workflow, provides commands | Correct git worktree usage |
| 13 | `using-workflows` | "What workflows are available and when should I use them?" | Explains brainstorm→plan→work→review→compound | Accurate workflow description |

### Quality & Verification

| # | Skill | Test Scenario | Expected Behavior | Verify |
|---|-------|---------------|-------------------|--------|
| 14 | `verification-before-completion` | "Mark task as done" (without running tests) | Blocks completion, requires test/lint pass | Refuses until verified |

### Framework-Specific

| # | Skill | Test Scenario | Expected Behavior | Verify |
|---|-------|---------------|-------------------|--------|
| 15 | `react-useeffect` | "Add a useEffect to fetch user data on mount" | Proper deps array, cleanup function, race condition handling | Correct React patterns |

### Workflow Capture

| # | Skill | Test Scenario | Expected Behavior | Verify |
|---|-------|---------------|-------------------|--------|
| 16 | `compound` | "Document the fix we just made" (after solving a bug) | Creates `docs/solutions/<category>/<slug>.md` with problem/solution | File created with YAML frontmatter |
| 17 | `review` | "Review this codebase for issues" | Spawns parallel review agents, synthesizes findings, creates TodoWrite items | Findings logged with P1/P2/P3 severity |

### Authoring

| # | Skill | Test Scenario | Expected Behavior | Verify |
|---|-------|---------------|-------------------|--------|
| 18 | `writing-skills` | "Create a new skill for database migrations" | Follows skill structure: SKILL.md, examples.md, reference.md | Correct skill structure |

---

## 2. Agents (20)

### Core Agents

| # | Agent | Test Scenario | Expected Behavior | Verify |
|---|-------|---------------|-------------------|--------|
| 1 | `codebase-search` | "Where is hook wiring defined in this repo?" | Spawns search agent, finds settings.json.example | Accurate file location |
| 2 | `open-source-librarian` | "How does the bats testing framework work?" | Web search, finds docs, provides cited answer | Citations included |
| 3 | `oracle` | "I've failed 3 times fixing this test. Help." | Deep analysis, architectural review, root cause | Comprehensive analysis |
| 4 | `tech-docs-writer` | "Write documentation for the delegator integration" | Creates well-structured docs with examples | Proper doc format |
| 5 | `media-interpreter` | "Extract info from this PDF" (provide PDF path) | Processes PDF, extracts content | Content extracted |

### Review Agents (14)

| # | Agent | Test Scenario | Expected Behavior | Verify |
|---|-------|---------------|-------------------|--------|
| 6 | `review/typescript` | "Review tests/schema_test.py for TypeScript patterns" | N/A (Python file), should note mismatch | Recognizes language |
| 7 | `review/python` | "Review tests/schema_test.py" | Python-specific review | Python patterns checked |
| 8 | `review/security-sentinel` | "Security review hooks/keyword-detector.py" | Checks injection, input validation, permissions | Security issues flagged |
| 9 | `review/performance-oracle` | "Performance review the glob patterns in tests" | Identifies inefficient patterns | Performance issues |
| 10 | `review/architecture-strategist` | "Review the overall config architecture" | High-level design review | Architectural feedback |
| 11 | `review/agent-native` | "Review how agents are structured" | Reviews agent design patterns | Agent pattern feedback |
| 12 | `review/code-simplicity` | "Review CLAUDE.md for complexity" | Identifies over-engineering | Simplification suggestions |
| 13 | `review/data-integrity-guardian` | "Review config/delegator/experts.json" | Checks data consistency | Data issues flagged |
| 14 | `review/data-migration-expert` | "Review if config changes need migrations" | Migration planning | Migration steps |
| 15 | `review/deployment-verification` | "Review install.sh for deployment issues" | Deployment checklist | Deployment issues |
| 16 | `review/dhh-rails` | N/A (no Rails code) | Skip or note inapplicable | - |
| 17 | `review/rails` | N/A (no Rails code) | Skip or note inapplicable | - |
| 18 | `review/frontend-races` | "Review for race conditions in hooks" | Concurrency issues | Race conditions |
| 19 | `review/pattern-recognition` | "Find repeated patterns across agents" | Pattern analysis | Patterns identified |
| 20 | `review/index` | "Run a comprehensive code review" | Orchestrates multiple reviewers | Multi-agent review |

---

## 3. Hooks (4)

| # | Hook | Trigger | Test Scenario | Expected Behavior | Verify |
|---|------|---------|---------------|-------------------|--------|
| 1 | `keyword-detector.py` | UserPromptSubmit | Say "ultrawork" or "sparc" in prompt | Detects keyword, suggests relevant skill | Keyword detected in output |
| 2 | `check-comments.py` | PostToolUse (Write/Edit) | Write code with excessive comments | Flags comment policy violation | Warning about comments |
| 3 | `todo-enforcer.sh` | Stop | Try to end session with incomplete todos | Blocks exit, lists incomplete items | Exit blocked |
| 4 | `require-green-tests.sh` | Stop | Try to finish with failing tests | Blocks until tests pass | Exit blocked |

---

## 4. Rules (8)

| # | Rule | Scope | Test Scenario | Expected Behavior | Verify |
|---|------|-------|---------------|-------------------|--------|
| 1 | `typescript.md` | `**/*.{ts,tsx}` | "Create a TypeScript file in this repo" | TypeScript conventions applied | TS rules followed |
| 2 | `testing.md` | `**/*.{test,spec}.ts` | "Write a test file" | BDD comments, proper structure | Test patterns used |
| 3 | `comments.md` | All files | Write any code | No obvious/redundant comments | Minimal comments |
| 4 | `forge.md` | `**/*.sol` | "Create a Solidity contract" | Foundry/ZKsync patterns | Solidity rules |
| 5 | `delegator/orchestration.md` | Global | Use delegator workflow | Proper orchestration flow | Flow followed |
| 6 | `delegator/triggers.md` | Global | Complex task that should delegate | Correct delegation triggers | Delegation happens |
| 7 | `delegator/model-selection.md` | Global | Delegate to expert | Correct model selected | Right expert chosen |
| 8 | `delegator/delegation-format.md` | Global | Any delegation | 7-section format used | Format correct |

---

## 5. Commands/Workflows (9)

### Core Workflows

| # | Command | Test Scenario | Expected Behavior | Verify |
|---|---------|---------------|-------------------|--------|
| 1 | `/interview` | "/interview" | Interactive spec clarification | Questions asked |
| 2 | `/workflows/brainstorm` | "/workflows/brainstorm caching-strategy" | Generates options, assesses risks | Multiple options |
| 3 | `/workflows/plan` | "/workflows/plan feature-x" | Creates plans/feature-x.md | Plan file created |
| 4 | `/workflows/work` | "/workflows/work" (with existing plan) | Executes tasks, updates status | Status updates |
| 5 | `/workflows/review` | "/workflows/review" | Multi-agent code review | Multiple reviewers run |
| 6 | `/workflows/compound` | "/workflows/compound" | Captures solution in docs/solutions/ | Solution documented |

### Delegator Commands

| # | Command | Test Scenario | Expected Behavior | Verify |
|---|---------|---------------|-------------------|--------|
| 7 | `/claude-delegator/setup` | "/claude-delegator/setup" | Configures Codex MCP | Setup instructions |
| 8 | `/claude-delegator/task` | "/claude-delegator/task review this code" | Delegates to Codex expert | Expert delegation |
| 9 | `/claude-delegator/uninstall` | "/claude-delegator/uninstall" | Removes delegator config | Cleanup instructions |

---

## Integrated Test Scenarios

These scenarios test multiple components working together:

### Scenario A: Full Feature Development Cycle

```
1. "/workflows/brainstorm add-metrics-collection"     → brainstorming skill
2. "/workflows/plan add-metrics-collection"           → planning-with-files skill
3. "/workflows/work"                                  → executing-plans skill
4. (Write code)                                       → rules apply, hooks fire
5. "/workflows/review"                                → review agents spawn
6. "Mark as done"                                     → verification skill blocks until tests pass
7. "/workflows/compound"                              → documents solution
```

**Components Tested**: 5 workflows, 3 skills, all rules, hooks

### Scenario B: Parallel Agent Orchestration

```
1. "Review this codebase for security, performance, and architecture issues"
2. Should spawn: security-sentinel, performance-oracle, architecture-strategist in PARALLEL
3. Results aggregated
```

**Components Tested**: dispatching-parallel-agents skill, 3 review agents

### Scenario C: Research + Implementation

```
1. "How does BATS testing work? Then add BATS tests to this repo"
2. open-source-librarian agent researches
3. test-driven-development skill guides implementation
4. testing.md rule applies
```

**Components Tested**: 1 agent, 1 skill, 1 rule

### Scenario D: Debugging Flow

```
1. "The schema_test.py is failing with X error"
2. systematic-debugging skill activates
3. codebase-search agent finds relevant code
4. Fix applied, tests run
5. verification-before-completion skill ensures pass
```

**Components Tested**: 2 skills, 1 agent, hooks

---

## Execution Checklist

Run through each section, marking completion:

- [ ] **Skills**: All 18 tested
- [ ] **Agents**: All 20 tested
- [ ] **Hooks**: All 4 tested
- [ ] **Rules**: All 8 tested
- [ ] **Commands**: All 9 tested
- [ ] **Integrated Scenario A**: Complete
- [ ] **Integrated Scenario B**: Complete
- [ ] **Integrated Scenario C**: Complete
- [ ] **Integrated Scenario D**: Complete

---

## Notes

- Some agents (dhh-rails, rails) won't apply to this repo — note as "N/A"
- Hooks require `settings.json` wiring to fire
- Delegator commands require Codex CLI setup
- Run integrated scenarios last after individual component validation
