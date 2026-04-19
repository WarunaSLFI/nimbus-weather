# Project Context

Living document. Updated after every feature or decision. Read this before starting any session.

## Current Status

**Foundation phase — no features implemented yet.** Design system is locked in: glassmorphic, Inter font, 3-tier glass system, Tampere default location at −2 °C, snowy. Next.js project has not yet been scaffolded.

## Tech Stack Decisions

| Technology | Why Chosen | Alternatives Considered |
| --- | --- | --- |
| Next.js 16 (App Router) | Server Components reduce client bundle; Turbopack is stable and fast; first-class Vercel integration | Remix, Astro, Vite + React Router |
| TypeScript strict + `noUncheckedIndexedAccess` | Catches array-index bugs at compile time; signals rigor for recruiter review | Loose TS, JavaScript |
| Tailwind + CSS custom properties | Utility speed without losing dynamic theming (weather-reactive `--accent`) | CSS Modules, vanilla-extract, Panda CSS |
| shadcn/ui | Copy-in primitives, not a dependency — keeps bundle small and styling fully owned | Radix alone, Headless UI, MUI |
| Recharts | Declarative React API, good accessibility defaults | Visx, Nivo, ECharts, D3 directly |
| Framer Motion | Ergonomic spring + gesture API; respects `prefers-reduced-motion` easily | React Spring, CSS keyframes |
| Open-Meteo | Free, no API key, generous rate limits; covers forecast + air-quality + historical | OpenWeatherMap (paid), WeatherAPI (limited free tier) |
| pnpm | Faster installs, strict dependency resolution, smaller `node_modules` | npm, yarn, bun |
| Vitest | Vite-native, fast HMR in tests, Jest-compatible API | Jest |
| Playwright | Cross-browser, great DX, best-in-class trace viewer | Cypress |
| Biome | Single binary for lint + format, 10–20x faster than ESLint + Prettier, zero-config | ESLint + Prettier |
| Vercel | Zero-config Next.js deploys, fast edge network, free tier covers portfolio scale | Netlify, Cloudflare Pages |

## Completed Features

- _None yet._

## Architecture Patterns

- _To be populated as features land._

## API Integration

**Open-Meteo** — free, keyless, no authentication required.

- Current weather & forecast: `https://api.open-meteo.com/v1/forecast`
- Air quality: `https://air-quality-api.open-meteo.com/v1/air-quality`
- Geocoding for location search: `https://geocoding-api.open-meteo.com/v1/search`

Every response is validated through a Zod schema in `src/lib/api/` before reaching components. Requests use `AbortController` for cancellation and exponential backoff retry (max 2 retries, 8 s timeout).

## Known Limitations

- _To be populated as constraints surface._

## Next Milestones

1. Scaffold Next.js 16 project (`pnpm create next-app` with App Router + TS).
2. Install dependencies (Tailwind, shadcn CLI, Recharts, Framer Motion, Zod, Biome, Vitest, Playwright).
3. Set up design tokens in `src/styles/tokens.css` (colors, blur tiers, accent map, spacing scale).
4. Build **Hero card** — large temperature, condition icon, location, animated scene layer.
5. Build **Hourly forecast chart** (Recharts, 24-hour line with temp + precipitation).
6. Build **10-day forecast** with daily min/max range bars.
7. Build **Radar map** (Leaflet or Mapbox + Open-Meteo precipitation tiles).
8. Build remaining metric cards (Air Quality, UV, Pollen, Wind, Humidity, Sunrise/Sunset).
9. Wire Open-Meteo API with Zod validation, retry, timeout, and `AbortController`.
10. Deploy to Vercel (`nimbus-weather.vercel.app`), add Lighthouse + axe-core CI checks.
