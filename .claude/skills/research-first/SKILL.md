---
name: research-first
description: Use this when the task involves new tech, auth or security work, third-party API integration, package selection, or anything where current best practices matter. Triggers on phrases like "integrate", "new API", "add auth", "install package", "which library", "best practice", "latest version", "upgrade", or "migrate". You can use this to avoid shipping stale patterns from training memory and to flag deprecations before code is written.
allowed-tools: WebSearch, WebFetch, Read
---

# Research First

Verify current practice on the web before writing code for unfamiliar or fast-moving domains. Training data lags the ecosystem — libraries rename APIs, auth flows deprecate, framework conventions shift. Search first, cite sources with dates, then propose.

## When to research (triggers)

Run research if the task includes any of:

- "integrate", "integration", "new API", "third-party"
- "add auth", "authentication", "OAuth", "session", "JWT", "cookies"
- "install package", "add dependency", "which library", "pick a library"
- "best practice", "recommended way", "idiomatic"
- "latest version", "upgrade", "migrate", "breaking change"
- Any library not yet touched this session (check `package.json` with Read)
- Any security-sensitive surface (CSP, CORS, tokens, crypto, SSRF, XSS)

## When to SKIP research

Go straight to code for:

- Basic CRUD against an API that is already wired
- CSS, Tailwind utilities, layout, responsive tweaks
- Standard React patterns (props, state, effects, context) on libraries already in use
- Refactors in existing code — rename, move, reorganise
- Bug fixes in code you can read and reason about locally
- Tests for existing code paths

If unsure, search. A wasted search is cheaper than a deprecated API in production.

## Workflow

1. **Decide.** Match the task against the trigger and skip lists above. If a trigger fires, research; otherwise proceed straight to code.
2. **Search.** Run 2–4 targeted WebSearch queries. Include the current year for framework or library topics so results reflect the current ecosystem.
3. **Summarize.** 3–6 bullets covering: recommended approach, current stable version, deprecations, breaking changes since the last major, gotchas.
4. **Cite.** Every non-obvious claim gets a source link with a page date or "as of <month> <year>". No bare assertions from training memory.
5. **Flag.** Surface every breaking change, security advisory, or deprecation explicitly — one line each, prefixed with `⚠` so the owner cannot miss them.
6. **Propose.** Suggest an approach grounded in the findings. Include the packages and versions you would install, and the files you would touch.
7. **Wait.** Do not start coding until the owner approves the approach. Course corrections belong here, before the keyboard is warm.

## Queries that work

Bad: `react auth`
Good: `next.js 16 app router auth best practices 2026`

Bad: `how to use tanstack query`
Good: `tanstack query v5 react 19 suspense migration 2026`

Include framework major version, library version when known, and the year.

## Self-review before handing off

- [ ] Did I actually run WebSearch, or am I recalling from training?
- [ ] Does every non-trivial claim have a dated source link?
- [ ] Did I flag every deprecation and breaking change I found?
- [ ] Did I propose a concrete approach, not a menu of options?
- [ ] Am I waiting for approval instead of coding?

## One exception

If the owner types `just do it` or `skip research`, proceed to code. Log one line noting the shortcut so it is visible in the transcript.
