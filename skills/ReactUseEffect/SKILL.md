---
name: ReactUseEffect
description: React useEffect best practices from official docs. USE WHEN writing useEffect OR reviewing Effects OR useState for derived values OR data fetching OR state synchronization.
---

# ReactUseEffect

You might not need an Effect. Effects are an escape hatch from React.

## Workflow Routing

| Workflow | Trigger | File |
|----------|---------|------|
| **ReviewEffect** | "useEffect", "effect", "data fetching" | Inline |

## Quick Reference

| Situation | DON'T | DO |
|-----------|-------|-----|
| Derived state | `useState` + `useEffect` | Calculate during render |
| Expensive calculations | `useEffect` to cache | `useMemo` |
| Reset state on prop change | `useEffect` with `setState` | `key` prop |
| User event responses | `useEffect` watching state | Event handler directly |
| Notify parent | `useEffect` calling `onChange` | Call in event handler |
| Fetch data | `useEffect` without cleanup | `useEffect` with cleanup OR framework |

## Examples

**Example 1: Derived state**
```
User: "Add useEffect to update fullName when first/last name changes"
→ Invokes ReactUseEffect
→ Recommends: calculate during render instead
→ const fullName = firstName + ' ' + lastName
```

**Example 2: Data fetching**
```
User: "Fetch user data on mount"
→ Invokes ReactUseEffect
→ Shows proper cleanup pattern with AbortController
→ Warns about race conditions
```
