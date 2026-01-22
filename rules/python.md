---
paths: "**/*.py"
---

## Python Rules

### Naming Conventions
- PascalCase for classes
- snake_case for functions, variables, methods, modules
- SCREAMING_SNAKE_CASE for constants
- _leading_underscore for private/internal
- __double_leading for name mangling (rare)

### Type Hints (Required)
- Always use type hints for function signatures
- Use `typing` module for complex types
- Prefer `None` over `Optional[T]` when using Python 3.10+ union syntax
- Use `list[T]`, `dict[K, V]` over `List[T]`, `Dict[K, V]` (Python 3.9+)

```python
# Good
def process_items(items: list[str], limit: int | None = None) -> dict[str, int]:
    pass

# Avoid (unless Python < 3.9)
from typing import List, Dict, Optional
def process_items(items: List[str], limit: Optional[int] = None) -> Dict[str, int]:
    pass
```

### Imports
- Group imports: stdlib → third-party → local
- Use absolute imports over relative (except within packages)
- One import per line for `from` imports
- Alphabetize within groups

```python
# Standard library
import os
import sys
from pathlib import Path

# Third-party
import numpy as np
import pandas as pd
from flask import Flask, request

# Local
from myapp.models import User
from myapp.utils import helper
```

### Error Handling
- Prefer specific exceptions over generic `Exception`
- Always include context in exception messages
- Use `finally` for cleanup, not `else` after try/except
- Don't use bare `except:` (always specify exception type)

```python
# Good
try:
    result = risky_operation()
except FileNotFoundError as e:
    logger.error(f"File not found: {e}")
    raise
except ValueError as e:
    logger.warning(f"Invalid value: {e}")
    return None

# Bad
try:
    result = risky_operation()
except:  # Too broad, hides bugs
    pass
```

### Async/Await
- Use `asyncio` for I/O-bound concurrency
- Always await async functions
- Use `async with` for async context managers
- Prefer `asyncio.gather()` for parallel operations

```python
# Good
async def fetch_multiple(urls: list[str]) -> list[str]:
    tasks = [fetch_url(url) for url in urls]
    return await asyncio.gather(*tasks)

# Bad - sequential instead of parallel
async def fetch_multiple(urls: list[str]) -> list[str]:
    results = []
    for url in urls:
        results.append(await fetch_url(url))
    return results
```

### Data Classes & Models
- Use `@dataclass` for simple data containers
- Use `pydantic` for validation-heavy models
- Prefer immutable data structures (`frozen=True`)
- Use `__slots__` for memory optimization when needed

```python
from dataclasses import dataclass

@dataclass(frozen=True)
class Config:
    host: str
    port: int
    debug: bool = False
```

### Context Managers
- Always use context managers for resources (files, connections, locks)
- Implement `__enter__` and `__exit__` or use `contextlib`
- Prefer `with` over manual try/finally

```python
# Good
with open('file.txt') as f:
    data = f.read()

# Bad
f = open('file.txt')
data = f.read()
f.close()
```

### List/Dict Comprehensions
- Use comprehensions for simple transformations
- Use regular loops for complex logic (>2 conditions)
- Don't sacrifice readability for brevity

```python
# Good
squares = [x**2 for x in range(10) if x % 2 == 0]

# Too complex - use regular loop
result = [
    process(x) 
    for x in items 
    if x.valid and x.ready and not x.processed
    for y in x.children 
    if y.active
]
```

### String Formatting
- Use f-strings (Python 3.6+) for string interpolation
- Use `.format()` only when f-strings aren't suitable
- Never use `%` formatting in new code

```python
# Good
message = f"User {user.name} logged in at {timestamp}"

# Acceptable for dynamic formatting
template = "Hello, {name}!"
message = template.format(name=username)

# Bad
message = "User %s logged in at %s" % (user.name, timestamp)
```

### Documentation
- Use docstrings for all public modules, classes, functions
- Follow Google or NumPy docstring style (be consistent)
- Include parameter types, return types, and exceptions

```python
def calculate_score(data: dict[str, float], weights: list[float]) -> float:
    """Calculate weighted score from data.
    
    Args:
        data: Dictionary mapping metric names to values
        weights: List of weight values for each metric
        
    Returns:
        Calculated weighted score
        
    Raises:
        ValueError: If weights length doesn't match data length
    """
    pass
```

### Testing
- Use `pytest` over `unittest` for new projects
- One assertion per test (or closely related assertions)
- Use fixtures for setup/teardown
- Use `parametrize` for testing multiple inputs

```python
import pytest

@pytest.fixture
def sample_data():
    return {"key": "value"}

@pytest.mark.parametrize("input,expected", [
    (1, 2),
    (2, 4),
    (3, 6),
])
def test_double(input, expected):
    assert double(input) == expected
```

### Performance
- Use generators for large sequences
- Prefer `itertools` over manual loops
- Use `collections` specialized containers (defaultdict, Counter, deque)
- Profile before optimizing (`cProfile`, `line_profiler`)

```python
# Good - memory efficient
def read_large_file(path: Path) -> Iterator[str]:
    with open(path) as f:
        for line in f:
            yield process_line(line)

# Bad - loads entire file into memory
def read_large_file(path: Path) -> list[str]:
    with open(path) as f:
        return [process_line(line) for line in f]
```

### Code Quality
- Maximum line length: 88 characters (Black default) or 100
- Use `black` for formatting
- Use `ruff` for linting (or `pylint`/`flake8`)
- Use `mypy` for type checking
- Run formatters/linters in pre-commit hooks

### Anti-Patterns (NEVER DO)
- Mutable default arguments: `def func(items=[]):`
- Bare `except:` without exception type
- Using `eval()` or `exec()` on untrusted input
- Modifying list while iterating over it
- Comparing to `True`/`False` with `==` (use `if x:` not `if x == True:`)

### Project Structure
```
myproject/
├── src/
│   └── myproject/
│       ├── __init__.py
│       ├── main.py
│       └── utils.py
├── tests/
│   ├── __init__.py
│   └── test_utils.py
├── pyproject.toml
├── README.md
└── .gitignore
```

### Dependencies Management
- Use `pyproject.toml` for modern projects
- Pin exact versions in production
- Use virtual environments (venv, poetry, conda)
- Keep dependencies minimal and up-to-date
