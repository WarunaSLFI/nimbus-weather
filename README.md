# Nimbus Weather Dashboard

A glassmorphic weather dashboard with animated scenes and weather-reactive theming.

![Nimbus Hero](./docs/screenshots/hero.png)

**Live demo:** [nimbus-weather.vercel.app](https://nimbus-weather.vercel.app)

![Next.js](https://img.shields.io/badge/Next.js-16-000?logo=next.js&logoColor=white)
![TypeScript](https://img.shields.io/badge/TypeScript-strict-3178C6?logo=typescript&logoColor=white)
![Tailwind CSS](https://img.shields.io/badge/Tailwind-CSS-38BDF8?logo=tailwindcss&logoColor=white)
![Vercel](https://img.shields.io/badge/Vercel-deployed-000?logo=vercel&logoColor=white)

## Features

- **Glassmorphic UI** with a three-tier blur system and inner-highlight edge treatment.
- **Any-location search** via Open-Meteo geocoding — works worldwide, no API key.
- **Animated weather scenes** (snow, rain, clouds, sun, storm) that react to current conditions.
- **10-day forecast** with daily min/max range bars and condition icons.
- **Interactive radar map** with live precipitation tiles.
- **Air quality, UV index, and pollen** alongside wind, humidity, and sunrise/sunset.
- **Light and dark themes** with weather-reactive accent colors.
- **Full keyboard navigation and screen-reader labels** — built to WCAG 2.2 AA.
- **Responsive** from 360 px mobile up through ultrawide desktop.

## Built with Claude Code

This project was developed using an AI-assisted workflow with [Claude Code](https://claude.ai/code). The prompts, skills, and agents that shaped the build are versioned in [`.claude/skills/`](./.claude/skills/) as part of the repository — process transparency, not co-authorship. All design decisions, code, and commits are my own.

## Getting Started

```bash
git clone https://github.com/WarunaSLFI/nimbus-weather.git
cd nimbus-weather
pnpm install
pnpm dev
```

Open [http://localhost:3000](http://localhost:3000). No API keys required — Open-Meteo is free and keyless.

## Project Structure

```
nimbus-weather/
├── src/
│   ├── app/                  # Next.js App Router routes
│   ├── components/
│   │   ├── ui/               # shadcn/ui primitives
│   │   ├── weather/          # Hero, HourlyForecast, TenDay, Radar, MetricCards
│   │   └── charts/           # Recharts wrappers
│   ├── lib/
│   │   ├── api/              # Open-Meteo client + Zod schemas
│   │   ├── utils/            # Formatters, helpers
│   │   └── constants/        # Accent map, condition enums
│   ├── hooks/                # useWeather, useGeolocation
│   ├── types/                # Shared TS types
│   └── styles/
│       ├── globals.css
│       └── tokens.css        # Design tokens (CSS custom properties)
├── .claude/                  # Skills, agents, commands (AI workflow)
├── CLAUDE.md                 # Claude Code rules
├── AGENTS.md                 # Universal AI agent rules
└── PROJECT_CONTEXT.md        # Living project status
```

## Design System

- **Typography:** Inter across the board, with OpenType features `ss01`, `cv11`, and `tnum` enabled for sharp numerals and curved-tail characters.
- **Glassmorphism** in three tiers — primary cards (24 px blur), nested surfaces (12 px), and overlays (40 px). Every glass surface carries a 1 px inner highlight for a crisp top edge.
- **Weather-reactive accent** — a single `--accent` CSS variable swaps with the current condition, tinting charts, icons, and focus rings in real time.
- **Base gradient:** `#0A0B14 → #141828`, with a 0.015-opacity noise overlay on large surfaces to kill banding.

## License

[MIT](./LICENSE)

## Author

**Waruna Rathnamalala** — Software Engineering student at TAMK, based in Tampere, Finland.

- Portfolio: [warunaslfi.com](https://warunaslfi.com)
- GitHub: [@WarunaSLFI](https://github.com/WarunaSLFI)
- Email: [warunaslfi@gmail.com](mailto:warunaslfi@gmail.com)
