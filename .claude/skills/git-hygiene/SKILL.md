---
name: git-hygiene
description: You can use this when making commits, writing commit messages, or preparing pull requests to enforce Conventional Commits, block AI attribution, and keep the history readable in a public portfolio repo. Triggers on "commit", "push", "merge", "PR", "squash", "rebase", or "clean up history".
allowed-tools: Bash, Read
---

# Git Hygiene

Defer to CLAUDE.md for project-specific overrides.

## When to activate

Trigger on any of: "commit", "git commit", "make a commit", "push", "merge", "pull request", "PR", "squash", "rebase", "clean up history", or any request mentioning git workflow.

## Absolute rules — never violate

NEVER include in commit messages, PR descriptions, or commit trailers:

- `Co-Authored-By: Claude <noreply@anthropic.com>`
- `Generated with Claude Code` or any AI tool reference
- 🤖 emoji or similar
- `@anthropic`, `@claude`, "AI-assisted" attributions
- "Made with AI" badges or mentions

All commits must be authored by the repository owner. Commit messages are in the owner's voice — human-sounding, never tool-branded.

## Conventional Commits format

```
<type>(<scope>): <short description>

[optional body]

[optional footer]
```

### Rules (with reasoning)

- **Subject fits one terminal line** — scannable in `git log --oneline` and fits the GitHub PR title preview. Aim for ≤50 chars; ≤72 is the hard ceiling before GitHub truncates the PR list.
- **Lowercase type and description** — release tooling (commitlint, semantic-release, release-please) pattern-matches on lowercase; mixed case breaks version bumping.
- **Present-tense imperative** — reads as an instruction to the codebase ("add snow particles" = "applying this commit will add snow particles"). Matches git's own merge-commit mood.
- **One logical change per commit** — keeps `git bisect` useful; a regression points at one diff, not a grab bag.
- **Scope is optional but recommended** — makes `git log --grep='^feat(hero):'` work as a change lens.

### Types used in this project

- `feat` — a visible change to the app (new card, new route, new interaction). Requires something a user could point to.
- `fix` — corrects broken behaviour; pair with a short body describing the symptom if non-obvious.
- `docs` — CLAUDE.md, AGENTS.md, README.md, PROJECT_CONTEXT.md, inline code docs.
- `refactor` — internal restructuring with no behaviour change.
- `perf` — measurable speed-up or bundle reduction (include the number in the body).
- `test` — adding or updating Vitest / Playwright specs.
- `build` — `package.json`, `pnpm-lock.yaml`, `next.config.ts`, Biome config.
- `ci` — `.github/workflows/`, Vercel config.
- `chore` — anything under `.claude/`, `scripts/`, or housekeeping that touches no runtime code.
- `style` — formatting only; rarely used manually because Biome handles this.

### Judging ambiguous types

- Adding tooling with no user-visible effect? `chore`, not `feat`. Example: `chore(claude): add settings and attribution hook`.
- Fixing a bug by restructuring the surrounding code? If the restructure is the fix, `fix`; if incidental, two commits (`refactor` + `fix`).
- Updating a README alongside a workflow file? Two commits (`ci` + `docs`), unless the README note is a single line — then `ci` with a one-line body.
- In genuine doubt, `chore` is the safest underclaim — better than `feat` for something with no user impact.

## Commit bodies

Add a body when the subject can't carry the context:

- The *why* isn't obvious from the diff (regulatory requirement, upstream bug, undocumented API quirk).
- There's a breaking change — describe the migration in the footer: `BREAKING CHANGE: <what broke>, <how to migrate>`.
- The change resolves an issue — `Refs: #123` or `Closes: #123` footer.

Body style: blank line between subject and body, wrap at 72 chars, full sentences in the owner's voice.

## Workflow for making a commit

1. **Check state** — `git status` to see what changed.
2. **Stage intentionally** — `git add <specific files>`, never `git add .` blindly (risks committing `.env*`, caches, editor scratch files).
3. **Verify staging** — `git status` again to confirm only intended paths are staged.
4. **Draft the message** — follow Conventional Commits, verify no AI references.
5. **Commit** — `git commit -m "type(scope): description"`, or a HEREDOC when a body is needed.
6. **Verify** — `git log -1` to confirm subject, author, and clean trailer.

## Interactive vs auto mode

- **Interactive (default):** show the proposed message and wait for acknowledgement before `git commit`. Never auto-commit without showing first.
- **Auto mode or explicit "just commit":** skip the confirmation step, commit, and print `git log -1` so the owner can review after the fact.

## Example commits (good)

```
feat(hero): add animated snowfall background
fix(api): handle open-meteo timeout gracefully
docs: add dashboard design reference
refactor(charts): extract shared axis config
chore(claude): add settings and attribution hook
test(hero): cover feels-like calculation edge cases
perf(radar): defer tile canvas until viewport-visible
```

## Example commits (bad — never do)

```
❌ Added stuff                              (not conventional)
❌ Feat: Added Hero                         (wrong case, past tense)
❌ feat: add hero card 🤖                   (emoji attribution)
❌ feat: add hero with Claude's help        (AI reference)
❌ updated README                           (no type prefix)
❌ feat: add complete dashboard             (scope too wide, one-shot)
❌ feat(`hero`): add card                   (backticks in subject)
```

## PR descriptions

Same rules apply. PR title follows Conventional Commits. Body describes:

- What changed and why.
- Any breaking changes with a migration note.
- Testing done — commands, browsers, viewports.

No "Generated by Claude", no co-author trailers, no AI mentions anywhere in PR metadata.

## Self-review before any commit

- [ ] Subject fits one terminal line (≤50 chars ideal, ≤72 ceiling)?
- [ ] Lowercase type + description?
- [ ] Present-tense imperative?
- [ ] No emoji in the subject?
- [ ] No backticks in the subject?
- [ ] No AI references anywhere in message, body, or trailers?
- [ ] Only one logical change staged?
- [ ] Author is the repo owner (`git config user.name`)?
