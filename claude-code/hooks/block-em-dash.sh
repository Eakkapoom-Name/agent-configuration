#!/usr/bin/env bash
# PreToolUse hook: block Write/Edit calls whose new content contains an em dash.
# Global rule: no em dashes in file edits, code, or chat responses.
set -uo pipefail

input=$(cat)
command -v jq >/dev/null 2>&1 || exit 0

tool=$(printf '%s' "$input" | jq -r '.tool_name // ""')
case "$tool" in
    Write) content=$(printf '%s' "$input" | jq -r '.tool_input.content // ""') ;;
    Edit) content=$(printf '%s' "$input" | jq -r '.tool_input.new_string // ""') ;;
    *) exit 0 ;;
esac

if printf '%s' "$content" | grep -qF $'\xe2\x80\x94'; then
    printf '%s' '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Blocked: em dash found in content. Global rule: no em dashes in file edits/code/chat. Use period, comma, or parentheses instead."}}'
fi

exit 0
