---
name: workflows-using-git-worktrees
description: Safely create, switch, and clean up git worktrees for parallel work.
---

# Using Git Worktrees

Use when you need multiple branches checked out at once.

Steps:
1. Create: `git worktree add ../<branch> <branch>` (branch must exist or use `-b`).
2. Switch by changing directories; never mix worktrees for the same branch.
3. Keep worktrees tidy: `git worktree list` to audit; remove with `git worktree remove <path>` after merging.
4. Avoid editing the same file across worktrees; pick one owner to prevent conflicts.
5. Clean up promptly after merges to avoid stale builds and disk bloat.
