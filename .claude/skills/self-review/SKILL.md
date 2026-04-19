---
name: self-review
description: You can use this before every commit or PR to catch bugs, security issues, and quality gaps early. Triggers on "finished feature", "before commit", "ready to commit", "review this", "done with", or any request to sanity-check work before shipping.
allowed-tools: Read, Grep, Glob, Bash
---

# Self Review

Defer to CLAUDE.md for project-specific overrides. This skill does not commit — hand off to git-hygiene after clearing all BLOCKING items.

## When to activate

Trigger on "finished", "before commit", "ready to commit", "done with", "review this", or any moment the owner is about to hand code off.

## Workflow

1. **Scope.** Ask what changed, or run `git diff --stat HEAD` to discover. Narrow review to touched files unless the owner says otherwise.
2. **Run each category.** Use the commands below. Classify findings as BLOCKING / MEDIUM / MINOR.
3. **Auto-fix trivial.** Typos, missing `aria-label` on icon buttons, obvious `any`, missing `alt` — fix and continue.
4. **Report non-trivial.** File + line + one-line suggested fix. Don't edit without asking.
5. **Re-run until clear.** Loop through fixes until BLOCKING is zero.
6. **Summarise.** Print remaining MEDIUM / MINOR items, then hand off to git-hygiene.

## Category checks

### 1. Architecture

- File lives in the correct folder per CLAUDE.md (`src/components/weather/` for dashboard cards, `src/lib/api/` for Open-Meteo, `src/hooks/` for hooks; never edit `src/components/ui/`).
- Single responsibility — split files that export three unrelated things.
- Glass surfaces use a tier class and include the inner-highlight token — don't hand-roll blur values. Check: `rg -n "backdrop-filter|backdrop-blur" src` should only match token references.
- No per-component `font-family` override — Inter is set on `<html>` with the feature-settings stack. Check: `rg -n "font-family" src/components` should return nothing.
- Three-level relative imports suggest a misplaced file: `rg "from '\.\./\.\./\.\./" src`.

### 2. Types

- `rg -n "\bany\b" --type ts src` — every `any` needs a nearby comment explaining why.
- `rg -n "@ts-ignore|@ts-expect-error" src` — must be accompanied by an issue reference.
- Props use `interface HeroProps`, not `type HeroProps =`. Check: `rg -n "^type \w+Props " src/components`.
- Every Open-Meteo response parsed through Zod: compare counts from `rg -n "fetch\(" src/lib/api` and `rg -n "\.parse\(|\.safeParse\(" src/lib/api`.

### 3. Error handling

- Every `await fetch(` has surrounding try/catch or `.catch(`. Check: `rg -n -B1 -A5 "await fetch\(" src`.
- Fetches use `AbortController` and a timeout: `rg -n "AbortController|signal:" src/lib/api`.
- Every async UI has loading, error, AND empty render paths — confirm all three for each Client Component added.
- No silent catches: `rg -n "catch\s*\{\s*\}" src`.

### 4. Security

- No secrets or keyed URLs: `rg -niE "sk_live|sk_test|api[_-]?key\s*=\s*['\"][A-Za-z0-9]{20,}" src`. Open-Meteo is keyless — any key string is a red flag.
- `.env*` not staged: `git diff --cached --name-only | rg "^\.env"` must be empty (only `.env.example` allowed).
- User input (search, URL params) validated through Zod before use.
- `rg -n "dangerouslySetInnerHTML" src` — each hit needs upstream sanitisation.

### 5. Accessibility

- Icon-only buttons have `aria-label`: `rg -n "<button[^>]*>" src/components | rg -v "aria-label"` should only show buttons with inner text.
- Every `<img>` has `alt` (empty string OK for decorative): `rg -n "<img " src | rg -v "alt="`.
- Colour is never the sole signal — temperature, condition, alert severity include text or icon as well.
- `prefers-reduced-motion` respected on Framer Motion: `rg -n "motion\." src/components`, confirm each uses `useReducedMotion()` or a conditional variant.
- Keyboard: Tab through the changed component in the browser, confirm the `--accent` focus ring is visible.

### 6. Tests

- New pure function in `src/lib/utils`? Sibling `.test.ts` in Vitest. Check: `fd -e ts -e tsx . src/lib/utils` vs `fd -e test.ts . src/lib/utils`.
- Sad paths covered: parse errors, network failures, empty forecast arrays, negative temperatures.
- User-facing feature? One Playwright spec exercising the golden path.

### 7. Git hygiene

Hand off to the git-hygiene skill for message format, staging, and author verification. Do not commit from this skill.

## Escape hatch

If the owner types `skip review` or `just commit`, log one line and pass straight to git-hygiene:

> Self-review skipped at owner's request; handing off to git-hygiene.

## Meta-checklist for this skill

- [ ] Every check is a concrete command, not a vague instruction.
- [ ] Every Nimbus-specific reference (Open-Meteo, glass tiers, Inter, Vitest, Playwright) matches CLAUDE.md.
- [ ] No AI attribution anywhere.
- [ ] Second-person voice in description and body.
- [ ] Handoff to git-hygiene is explicit (this skill does not commit).
