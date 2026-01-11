# Review Agents

These agents live under `agents/review/` and are dispatched by `/workflows:review`.

## Agent List
- `security-sentinel` — Security-focused reviewer for auth, injection, secrets handling, data exposure, and unsafe crypto.
- `performance-oracle` — Performance-focused reviewer for hot paths, scaling risks, and resource usage.
- `architecture-strategist` — Architecture reviewer for boundaries, coupling, and long-term maintainability.
- `data-migration-expert` — Database migration reviewer for safety, reversibility, and backfill risks.
- `deployment-verification` — Deployment readiness reviewer for configs, flags, and operational concerns.
- `code-simplicity` — Simplicity reviewer for complexity reduction and clarity.
- `data-integrity-guardian` — Data integrity reviewer for correctness, constraints, and consistency.
- `pattern-recognition` — Pattern reviewer for anti-patterns and consistency with existing codebase.
- `agent-native` — AI/agent-native reviewer for prompt/tooling safety and determinism.
- `typescript` — TypeScript reviewer for type safety and TS best practices.
- `rails` — Rails reviewer for conventions, performance, and correctness.
- `python` — Python reviewer for idioms, typing, and runtime correctness.
- `dhh-rails` — DHH-style Rails reviewer for convention over configuration and simplicity.
- `frontend-races` — Frontend reviewer for async race conditions and state consistency.
