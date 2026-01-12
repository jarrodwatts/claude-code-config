# Contributing to claude-code-config

Thanks for your interest in contributing! This project provides a production-ready configuration framework for Claude Code.

## Ways to Contribute

### Report Issues
- Bug reports with reproduction steps
- Feature requests with use cases
- Documentation improvements

### Submit Pull Requests
- Bug fixes
- New skills, agents, or rules
- Documentation updates
- Test coverage improvements

## Development Setup

1. Clone the repo:
   ```bash
   git clone https://github.com/Esk3nder/claude-code-config.git
   cd claude-code-config
   ```

2. Run structure tests:
   ```bash
   ./tests/structure_test.sh
   ```

3. Run schema tests:
   ```bash
   python3 tests/schema_test.py
   ```

## Pull Request Process

1. **Fork** the repository
2. **Create a branch** from `main` for your changes
3. **Make your changes** following the conventions below
4. **Run tests** to ensure nothing breaks
5. **Submit a PR** with a clear description of changes

## Conventions

### Skills
- Directory: `skills/{TitleCase}/SKILL.md`
- Must have YAML frontmatter with `name` and `description`
- Description must include `USE WHEN` clause
- Include `## Workflow Routing` and `## Examples` sections

### Agents
- File: `agents/{name}.md` or `agents/review/{name}.md`
- Must have YAML frontmatter with `name`, `description`, `tools`, `model`

### Commands
- File: `commands/{name}.md` or `commands/{category}/{name}.md`
- Must have YAML frontmatter with `allowed-tools` and `description`

### Hooks
- Python hooks: `hooks/{name}.py`
- Bash hooks: `hooks/{name}.sh` or `hooks/{category}/{name}.sh`
- Must handle stdin JSON and output valid JSON

### Rules
- File: `rules/{name}.md`
- Must have YAML frontmatter with `paths` glob pattern

## Code Style

- **Shell**: Follow shellcheck recommendations
- **Python**: Standard library only, no external dependencies
- **Markdown**: Use ATX-style headers (`#`), fenced code blocks

## Testing Your Changes

Before submitting:

```bash
# Structure tests
./tests/structure_test.sh

# Schema validation
python3 tests/schema_test.py

# Test hooks directly
echo '{"prompt": "test"}' | python3 hooks/keyword-detector.py
```

## Questions?

Open an issue for questions about contributing.

## Acknowledgments

This project builds on ideas from the Claude Code community. See README.md for specific acknowledgments.
