# AGENTS.md

Universal rules for any AI coding agent in this repo (Claude Code, Cursor, Copilot, Codex, Gemini CLI, Windsurf). Claude-specific detail lives in [CLAUDE.md](./CLAUDE.md).

## Rule 0 — No AI Attribution (Non-Negotiable)

This repo is public and used for job applications. AI attribution destroys recruiter credibility.

**Never produce any of the following in any file, commit, or PR:**

- `Co-Authored-By: Claude <noreply@anthropic.com>` or any AI co-author trailer
- "Generated with Claude Code", "Made with AI", or similar badges
- `🤖` emoji, `@anthropic`, `@claude`, or tool-branded signoffs
- Commits authored as anyone other than Waruna Rathnamalala

The only sanctioned mention is one honest "Built with Claude Code" transparency section in `README.md`.

## Stack (do not suggest alternatives)

Next.js 16 App Router · TypeScript strict · Tailwind · shadcn/ui · Recharts · Framer Motion · Open-Meteo (keyless) · pnpm · Vitest · Playwright · Biome · Vercel.

## Commits

Conventional Commits v1.0.0 — `type(scope): subject`. Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`. Example: `feat(radar): wire Open-Meteo precipitation layer`. Author: Waruna Rathnamalala `<warunaslfi@gmail.com>`.

## Code Expectations

- TypeScript strict with `noUncheckedIndexedAccess`. No `any`, no `@ts-ignore`.
- Validate every external response with Zod. Every async UI has loading, error, and empty states.
- Network calls use retry, timeout, and `AbortController`.
- No inline styles when a token exists. Glass surfaces need inner highlight `inset 0 1px 0 rgba(255,255,255,0.08)`.

## Workflow

Read `PROJECT_CONTEXT.md` first → check `.claude/skills/` for existing coverage → verify current docs before adopting new tech → update `PROJECT_CONTEXT.md` after each feature.

## Never

pnpm only · no editing `src/components/ui/` · no committing `.env*` except `.env.example` · no AI attribution (Rule 0).
