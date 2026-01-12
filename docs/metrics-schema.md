# Metrics Event Schema

**Version**: 1.0
**Format**: JSONL (one JSON object per line)
**Location**: `~/.claude/metrics/events.jsonl`

## Event Structure

```json
{
  "timestamp": "2026-01-12T10:30:00.000Z",
  "session_id": "abc123",
  "event_type": "keyword_detected",
  "data": {
    "keyword": "ultrawork",
    "suggested_skill": "sparc"
  }
}
```

## Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `timestamp` | ISO 8601 string | Yes | When the event occurred |
| `session_id` | string | Yes | Unique ID for the Claude Code session |
| `event_type` | string | Yes | Event category (see Event Types) |
| `data` | object | Yes | Event-specific payload |

## Event Types

### `keyword_detected`
Fired when keyword-detector.py identifies a trigger word.

```json
{
  "event_type": "keyword_detected",
  "data": {
    "keyword": "ultrawork",
    "suggested_skill": "sparc",
    "prompt_length": 150
  }
}
```

### `hook_executed`
Fired when any hook completes.

```json
{
  "event_type": "hook_executed",
  "data": {
    "hook_name": "check-comments.py",
    "trigger": "PostToolUse",
    "duration_ms": 45,
    "result": "pass"
  }
}
```

### `session_start`
Fired at session initialization.

```json
{
  "event_type": "session_start",
  "data": {
    "working_dir": "/path/to/project",
    "config_version": "1.0"
  }
}
```

### `session_end`
Fired on session termination.

```json
{
  "event_type": "session_end",
  "data": {
    "duration_seconds": 3600,
    "events_logged": 42
  }
}
```

## Session ID Generation

Session IDs are generated at session start using:
```python
import uuid
session_id = str(uuid.uuid4())[:8]
```

## Querying Events

```bash
# All events from today
cat ~/.claude/metrics/events.jsonl | jq 'select(.timestamp | startswith("2026-01-12"))'

# Count by event type
cat ~/.claude/metrics/events.jsonl | jq -s 'group_by(.event_type) | map({type: .[0].event_type, count: length})'

# Keywords detected
cat ~/.claude/metrics/events.jsonl | jq 'select(.event_type == "keyword_detected") | .data.keyword'
```

## Schema Versioning

Future schema changes will:
1. Increment version in this doc
2. Add `schema_version` field to events
3. Maintain backward compatibility where possible
