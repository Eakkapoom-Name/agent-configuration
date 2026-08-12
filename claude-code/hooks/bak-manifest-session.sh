#!/usr/bin/env bash
# SessionStart hook: tell Claude this session's id and manifest path, so the
# session-cleanup skill can find the right manifest without guessing.
#
# Must never break session startup: always exits 0.

set -uo pipefail

input=$(cat)
command -v jq >/dev/null 2>&1 || exit 0

session_id=$(printf '%s' "$input" | jq -r '.session_id // ""')
[[ -n "$session_id" ]] || exit 0
[[ "$session_id" =~ ^[A-Za-z0-9._-]+$ ]] || exit 0

manifest="$HOME/.claude/bak-manifest/${session_id}.txt"

context=".bak cleanup tracking: this session's id is ${session_id}. Any .bak file created this session is recorded in ${manifest}. The session-cleanup skill reads that file when ending the session."

jq -cn --arg ctx "$context" \
    '{hookSpecificOutput:{hookEventName:"SessionStart",additionalContext:$ctx}}' 2>/dev/null || true

exit 0
