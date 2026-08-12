#!/usr/bin/env bash
# UserPromptSubmit hook: standing reminder to invoke verifying-facts skill.
# Skill-list description matching is unreliable with ~150 skills listed each
# turn, so this injects a short reminder every turn instead, same mechanism
# caveman mode uses for its persistence.
set -uo pipefail

msg="Before stating any time-sensitive or invention-prone fact (versions, \"latest,\" pricing, package/flag/config names, URLs, deprecation status), invoke the verifying-facts skill and verify with a live source first. If you can't verify, say so and ask, don't guess."

jq -cn --arg ctx "$msg" \
    '{hookSpecificOutput:{hookEventName:"UserPromptSubmit",additionalContext:$ctx}}' 2>/dev/null || true

exit 0
