---
paths: "**/*.{ts,tsx}"
---

## TypeScript Rules

### Naming Conventions
- PascalCase for interfaces, types, classes, components
- camelCase for functions, variables, methods
- SCREAMING_SNAKE_CASE for constants
- kebab-case for file names

### Type Safety
- NO `any` without explicit justification comment
- NO `@ts-ignore` or `@ts-expect-error` without explanation
- Prefer `unknown` over `any` when type is truly unknown
- Use explicit return types on exported functions

### Imports
- Group imports: external → internal → relative
- Use named exports over default exports
- No circular dependencies

### Async/Await
- Always handle promise rejections
- Use try/catch for async operations
- Avoid floating promises (unhandled)

### React Best Practices
- When writing React code, invoke `vercel-react-best-practices` skill

### React Hooks
- When writing or reviewing `useEffect` or `useState` for derived values, invoke `react-useeffect` skill
- Prefer derived values over state + effect patterns
- Use `useMemo` for expensive calculations, not `useEffect`