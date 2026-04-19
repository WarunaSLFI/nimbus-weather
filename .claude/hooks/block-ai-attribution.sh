#!/usr/bin/env bash
# PreToolUse hook — blocks Write/Edit/Bash calls that embed AI attribution.
# Scope: this repo is public and used for job applications (see AGENTS.md Rule 0).

set -euo pipefail

payload="$(cat)"

# Exempt the policy files and this hook from the check — they legitimately
# quote the forbidden strings in order to prohibit them. Scoped to basename
# so a stray /tmp/CLAUDE.md can't bypass the check from a project path.
file_path="$(printf '%s' "$payload" | jq -r '.tool_input.file_path // empty')"
case "${file_path##*/}" in
  CLAUDE.md|AGENTS.md|block-ai-attribution.sh) exit 0 ;;
esac

haystack="$(
  printf '%s' "$payload" | jq -r '
    .tool_input |
    (.content // "") + "\n" +
    (.new_string // "") + "\n" +
    (.old_string // "") + "\n" +
    (.command // "")
  '
)"

pattern='co-authored-by:[[:space:]]*(claude|anthropic)|noreply@anthropic|generated with (claude|anthropic)|🤖[[:space:]]+generated with|made with[[:space:]]+(ai|claude)'

if printf '%s' "$haystack" | grep -qiE "$pattern"; then
  cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Blocked: AI attribution string detected in tool input. See AGENTS.md Rule 0 — this repo forbids Co-Authored-By trailers, 'Generated with' badges, and 🤖 emojis."}}
JSON
fi
