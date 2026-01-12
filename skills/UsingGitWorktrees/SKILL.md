---
name: UsingGitWorktrees
description: Safely create, switch, and clean up git worktrees. USE WHEN multiple branches needed OR parallel work OR worktree mentioned.
---

# UsingGitWorktrees

Manage multiple branches checked out simultaneously.

## Workflow Routing

| Workflow | Trigger | File |
|----------|---------|------|
| **Worktree** | "worktree", "multiple branches" | Inline |

## Process

1. Create: `git worktree add ../<branch> <branch>` (branch must exist or use `-b`).
2. Switch by changing directories; never mix worktrees for the same branch.
3. Keep worktrees tidy: `git worktree list` to audit; remove with `git worktree remove <path>` after merging.
4. Avoid editing the same file across worktrees; pick one owner to prevent conflicts.
5. Clean up promptly after merges to avoid stale builds and disk bloat.

## Examples

**Example 1: Parallel feature work**
```
User: "I need to work on two features at once"
→ Invokes UsingGitWorktrees
→ Creates worktrees for each branch
→ Explains directory switching
```

**Example 2: Hotfix while feature in progress**
```
User: "Need to fix a bug but don't want to stash"
→ Creates worktree for hotfix branch
→ Keeps feature work intact
```
