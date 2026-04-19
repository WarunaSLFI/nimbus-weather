---
name: component-scaffolder
description: You can use this to generate new React components for Nimbus with matching tests, typed props, and a barrel export. Triggers on "create component", "new component", "scaffold component", "add a card", or "build <Name>Card".
allowed-tools: Read, Write, Edit, Bash
---

# Component Scaffolder

Defer to CLAUDE.md for project-specific overrides. This skill does not commit — hand off to `self-review`, then to `git-hygiene`, after the owner approves.

## When to activate

Trigger on "create component", "new component", "scaffold component", "add a card", "build <Name>Card", or any request to lay down a new component with tests.

## Preconditions

Run these first; stop and explain if any fail:

1. `Read PROJECT_CONTEXT.md` to know the current phase and pending milestones.
2. `test -d src/components` — if missing, the Next.js project is not scaffolded yet; guide the owner to `pnpm create next-app` before continuing.
3. `rg -q '"shadcn' package.json && rg -q 'vitest' package.json && rg -q '@testing-library/react' package.json` — shadcn, Vitest, and Testing Library must be installed. If any is absent, stop and list what to add.

## Ask the owner

1. **Component name** — PascalCase, no speculative suffix (e.g. `HourlyForecast`, not `HourlyForecastCard` unless requested).
2. **Directory** — one of `ui`, `weather`, `charts`. Default `weather` for dashboard pieces.
3. **Client component?** — if it uses state, effects, browser APIs, or Framer Motion, it needs `"use client"`.

## Files to generate

Target path: `src/components/<dir>/<Name>/`.

### 1. `<Name>.tsx`

```tsx
"use client"; // include only if state, effects, motion, or browser APIs are used

import { cn } from "@/lib/utils/cn";

export interface <Name>Props {
  className?: string;
  // real props here — interface, never type alias, for Props
}

export default function <Name>({ className }: <Name>Props) {
  return (
    <section
      className={cn("glass-t1 rounded-2xl p-6", className)}
      aria-label="<Name> panel"
    >
      {/* content inherits Inter from <html> — never override font-family */}
    </section>
  );
}
```

Rules:

- Props typed as `interface <Name>Props`, destructured with defaults in the signature.
- Glass surfaces use a tier class (`glass-t1` primary, `glass-t2` nested, `glass-t3` overlays) — never hand-rolled `backdrop-filter`.
- `aria-label` on every interactive or landmark region.
- Framer Motion? Wrap variants with `useReducedMotion()` so motion respects the OS preference.
- No inline `style={{}}` when a Tailwind utility or CSS variable covers the case.

### 2. `<Name>.test.tsx`

```tsx
import { render, screen } from "@testing-library/react";
import { describe, it, expect } from "vitest";

import <Name> from "./<Name>";

describe("<Name>", () => {
  it("renders the landmark region", () => {
    render(<<Name> />);
    expect(screen.getByRole("region", { name: /<Name> panel/i })).toBeInTheDocument();
  });

  // add one interaction test (userEvent.click / type) if the component accepts input
  // add one sad-path test (missing required prop, error state) if applicable
});
```

### 3. `index.ts` (barrel)

Create if absent, otherwise append:

```ts
export { default as <Name> } from "./<Name>";
export type { <Name>Props } from "./<Name>";
```

## After generation

1. `pnpm tsc --noEmit` — verify types compile cleanly. If the run fails, fix or flag before handing off.
2. Print a short summary: files created, lines added, next suggested step.
3. Remind the owner to run the `self-review` skill before committing.

## Concrete example — `ForecastCard` in `weather`

- `src/components/weather/ForecastCard/ForecastCard.tsx` — component body, `"use client"` likely needed for Framer Motion.
- `src/components/weather/ForecastCard/ForecastCard.test.tsx` — render + one interaction test.
- `src/components/weather/ForecastCard/index.ts` — `export { default as ForecastCard } from "./ForecastCard";`.
- Update `src/components/weather/index.ts` with one more re-export line.

## Escape hatch

If the owner says `skip tests`, generate only the component and barrel, and log:

> Tests skipped at owner's request; `<Name>.test.tsx` not generated.

## Meta-checklist for this skill

- [ ] Preconditions checked before writing any file.
- [ ] Component uses a glass tier class, not hand-rolled blur.
- [ ] Props typed as `interface`, not `type`.
- [ ] Test file uses Vitest + Testing Library and covers at least one behaviour.
- [ ] Barrel export updated (and parent barrel, if present).
- [ ] Owner reminded to run `self-review` before commit.
