# CLAUDE.md

Guidance for Claude Code when working in this repository.

## Project Identity

- **Nimbus Weather Dashboard** — a glassmorphic weather dashboard with animated scenes.
- Portfolio project targeting Finnish tech companies (Reaktor, F-Secure, Supermetrics).
- Owner: Waruna Rathnamalala — Tampere, Finland. TAMK Software Engineering student.
- Repo is public. All content must read as Waruna's own work.

## Stack

- Next.js 16 (App Router, Server Components, Turbopack)
- TypeScript strict mode with `noUncheckedIndexedAccess`
- Tailwind CSS + CSS custom properties (design tokens in `src/styles/tokens.css`)
- shadcn/ui primitives (never edit `components/ui/` directly — wrap them)
- Recharts (charts), Framer Motion (animations, respect `prefers-reduced-motion`)
- Open-Meteo API (free, keyless) for current, forecast, air-quality
- pnpm (not npm, not yarn)
- Vitest (unit), Playwright (E2E), Biome (lint + format — not ESLint/Prettier)
- Deployed on Vercel

## Critical Rules — Non-Negotiable

- **Inter font everywhere** with `font-feature-settings: 'ss01', 'cv11', 'tnum'` on `<html>`.
- **Conventional Commits v1.0.0** — `type(scope): subject`. Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`. Example: `feat(hero): add snow particle layer`.
- **Zero AI attribution.** Never write `Co-Authored-By: Claude`, "Generated with Claude Code", `🤖`, `@anthropic`, or "Made with AI" anywhere in commits, files, or PRs. Commits are authored as Waruna Rathnamalala. The only sanctioned mention is the transparency section in `README.md`.
- **Runtime validation with Zod** on every external response (Open-Meteo, user input, URL params). Never trust the network.
- **Every async UI needs loading, error, and empty states.** No silent failures, no spinners forever.
- **Network calls need retry, timeout, and typed error handling.** Use `AbortController` for cancellation.

## Design System — Glassmorphism

- **Tier 1** (primary cards): `backdrop-filter: blur(24px) saturate(180%)`, background `rgba(255,255,255,0.06)`.
- **Tier 2** (nested inside Tier 1): `blur(12px) saturate(160%)`, background `rgba(255,255,255,0.04)`.
- **Tier 3** (overlays, modals): `blur(40px) saturate(200%)`, background `rgba(20,20,28,0.72)`.
- **Inner highlight required on every glass surface:** `box-shadow: inset 0 1px 0 rgba(255,255,255,0.08)`.
- Noise overlay at `0.015` opacity on large glass surfaces (Hero, Map).
- **Dynamic accent** via `--accent` CSS variable, set per weather condition: clear-day `#FFB547`, clear-night `#7B8FFF`, cloudy `#8B95A8`, rain `#4A9EFF`, snow `#C4E0FF`, storm `#A855F7`, fog `#B8B8C4`.
- Page gradient: `#0A0B14 → #141828`.

## File Structure

```
src/
  app/                 # App Router routes, layouts, pages
  components/
    ui/                # shadcn primitives — do not edit directly
    weather/           # Hero, HourlyForecast, TenDay, Radar, MetricCards
    charts/            # Recharts wrappers
  lib/
    api/               # Open-Meteo client + Zod schemas
    utils/             # Formatters, helpers
    constants/         # Accent map, condition enums
  hooks/               # useWeather, useGeolocation, etc.
  types/               # Shared TS types
  styles/
    globals.css        # Base + Tailwind layers
    tokens.css         # CSS custom properties (colors, blur, spacing)
```

## Workflow Rules

- **Read `PROJECT_CONTEXT.md` first** every session — it holds current status, decisions, and next milestones.
- **Check `.claude/skills/`** before implementing — a skill may already cover the task.
- **Research-first for new tech.** Verify current API docs before adopting a library or pattern.
- **Update `PROJECT_CONTEXT.md` after each feature** — move items from Next Milestones to Completed Features; record any new architecture patterns or known limitations.

## Never Do

- Do not use `npm` or `yarn`. pnpm only.
- Do not use `localStorage` for anything sensitive; prefer server state or URL params. No user data persisted client-side without explicit scope.
- Do not commit `.env`, `.env.local`, or any secret. Only `.env.example` goes in.
- Do not add AI attribution in any form (see Critical Rules).
- Do not edit files under `src/components/ui/` — wrap them in `src/components/weather/` instead.
- Do not write inline styles when a design token exists. Use `var(--token-name)`.
