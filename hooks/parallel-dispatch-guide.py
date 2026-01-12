#!/usr/bin/env python3
"""
Parallel Dispatch Guide - PreToolUse Hook
Auto-dispatches parallel agents when sequential exploration is detected
in review or multi-module contexts.

Hook Event: PreToolUse
Matcher: Read|Grep|Glob|Bash
"""

import json
import sys
import time
import re
from pathlib import Path

# State directory (created at runtime in user's home)
STATE_DIR = Path.home() / ".claude" / "hooks" / "state"
STATE_FILE = STATE_DIR / "parallel-dispatch.json"
CONTEXT_FILE = STATE_DIR / "session-context.json"

# Tools to intercept
EXPLORATION_TOOLS = {"Read", "Grep", "Glob"}

# Read-only Bash commands to intercept
READ_ONLY_BASH = re.compile(
    r'^(ls|find|git\s+(status|log|diff|show|branch)|cat|head|tail|wc|tree|file)\b'
)

# Thresholds
MIN_SCORE_TO_DISPATCH = 3
EXPLORATION_WINDOW_SECONDS = 60
MAX_AGENTS = 5

# Agent dispatch mapping
AGENT_MAP = {
    "review_security": "security-sentinel",
    "review_performance": "performance-oracle",
    "review_architecture": "architecture-strategist",
    "review_general": "code-simplicity",
    "exploration_mode": "codebase-search",
    "library_context": "open-source-librarian",
}


def load_state() -> dict:
    """Load or initialize session state."""
    STATE_DIR.mkdir(parents=True, exist_ok=True)

    if STATE_FILE.exists():
        try:
            data = json.loads(STATE_FILE.read_text())
            # Check if state is stale (> 30 min old)
            last_update = data.get("last_update_ts", 0)
            if time.time() - last_update > 1800:  # 30 minutes
                return init_state()
            return data
        except (json.JSONDecodeError, KeyError):
            pass

    return init_state()


def init_state() -> dict:
    """Initialize fresh state."""
    return {
        "exploration_count": 0,
        "first_exploration_ts": None,
        "agents_dispatched": False,
        "dispatched_agents": [],
        "last_update_ts": time.time(),
    }


def save_state(state: dict) -> None:
    """Persist session state."""
    state["last_update_ts"] = time.time()
    STATE_DIR.mkdir(parents=True, exist_ok=True)
    STATE_FILE.write_text(json.dumps(state, indent=2))


def load_context_flags() -> dict:
    """Load context flags set by keyword-detector hook."""
    if CONTEXT_FILE.exists():
        try:
            data = json.loads(CONTEXT_FILE.read_text())
            # Check freshness (context older than 5 min is stale)
            ts = data.get("timestamp", 0)
            if time.time() - ts < 300:
                return data
        except (json.JSONDecodeError, KeyError):
            pass
    return {}


def should_intercept(tool_name: str, tool_input: dict) -> bool:
    """Check if this tool call should be intercepted."""
    if tool_name in EXPLORATION_TOOLS:
        return True

    if tool_name == "Bash":
        cmd = tool_input.get("command", "")
        return bool(READ_ONLY_BASH.match(cmd.strip()))

    return False


def calculate_score(state: dict, context: dict) -> int:
    """Calculate parallelization recommendation score."""
    score = 0

    # Context flags from keyword-detector (highest weight)
    if context.get("review_security"):
        score += 3
    if context.get("review_performance"):
        score += 3
    if context.get("review_architecture"):
        score += 3
    if context.get("review_mode"):
        score += 2
    if context.get("multi_module"):
        score += 3
    if context.get("exploration_mode"):
        score += 2
    if context.get("library_context"):
        score += 2

    # Sequential exploration pattern (medium weight)
    now = time.time()
    first_ts = state.get("first_exploration_ts")
    if first_ts and (now - first_ts) < EXPLORATION_WINDOW_SECONDS:
        count = state.get("exploration_count", 0)
        if count >= 3:
            score += 2
        elif count >= 2:
            score += 1

    return score


def determine_agents(context: dict) -> list:
    """Determine which agents to dispatch based on context."""
    agents = []

    # Review-specific agents
    if context.get("review_security"):
        agents.append("security-sentinel")
    if context.get("review_performance"):
        agents.append("performance-oracle")
    if context.get("review_architecture"):
        agents.append("architecture-strategist")

    # General review (add pattern/simplicity agents)
    if context.get("review_mode") and not agents:
        agents.extend(["code-simplicity", "pattern-recognition"])

    # Exploration agents
    if context.get("exploration_mode"):
        agents.append("codebase-search")

    # Library/external reference
    if context.get("library_context"):
        agents.append("open-source-librarian")

    # Dedupe and cap
    seen = set()
    unique_agents = []
    for agent in agents:
        if agent not in seen:
            seen.add(agent)
            unique_agents.append(agent)

    return unique_agents[:MAX_AGENTS]


def build_dispatch_output(agents: list) -> dict:
    """Build the hook output for auto-dispatch."""
    agent_list = ", ".join(agents)

    return {
        "hookSpecificOutput": {
            "hookEventName": "PreToolUse",
            "permissionDecision": "allow",
            "autoDispatch": agents,
            "dispatchMode": "background",
            "systemMessage": f"""[PARALLEL AGENTS AUTO-DISPATCHED]

Detected review/exploration context. Auto-dispatching parallel agents:
{chr(10).join(f'  - {a}' for a in agents)}

These agents are running in background. Continue with your work.
Use TaskOutput to collect results when needed.

Per CLAUDE.md: "codebase-search/open-source-librarian = Grep, not consultants. Fire liberally."
""",
        }
    }


def main():
    try:
        input_data = json.load(sys.stdin)
    except json.JSONDecodeError:
        sys.exit(0)

    tool_name = input_data.get("tool_name", "")
    tool_input = input_data.get("tool_input", {})

    # Only intercept exploration tools
    if not should_intercept(tool_name, tool_input):
        sys.exit(0)

    state = load_state()
    context = load_context_flags()

    # Already dispatched agents this session?
    if state.get("agents_dispatched"):
        sys.exit(0)

    # Update exploration tracking
    now = time.time()
    first_ts = state.get("first_exploration_ts")

    if first_ts is None:
        state["first_exploration_ts"] = now
    elif (now - first_ts) > EXPLORATION_WINDOW_SECONDS:
        # Reset window
        state["first_exploration_ts"] = now
        state["exploration_count"] = 0

    state["exploration_count"] = state.get("exploration_count", 0) + 1
    save_state(state)

    # Calculate score
    score = calculate_score(state, context)

    if score >= MIN_SCORE_TO_DISPATCH:
        agents = determine_agents(context)
        if agents:
            state["agents_dispatched"] = True
            state["dispatched_agents"] = agents
            save_state(state)

            output = build_dispatch_output(agents)
            print(json.dumps(output))

    sys.exit(0)


if __name__ == "__main__":
    main()
