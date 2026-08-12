#!/usr/bin/env bash
# PostToolUse hook: record .bak files created during this session.
#
# Appends absolute paths of freshly-created *.bak files to
#   ~/.claude/bak-manifest/<session_id>.txt
# so the session-cleanup skill knows exactly what it may delete.
#
# Must never fail the tool call it observes: always exits 0.

set -uo pipefail

MANIFEST_DIR="$HOME/.claude/bak-manifest"
FRESH_SECONDS=120

input=$(cat)
command -v jq >/dev/null 2>&1 || exit 0

session_id=$(printf '%s' "$input" | jq -r '.session_id // ""')
[[ -n "$session_id" ]] || exit 0

# Refuse anything that could escape the manifest directory.
[[ "$session_id" =~ ^[A-Za-z0-9._-]+$ ]] || exit 0

tool=$(printf '%s' "$input" | jq -r '.tool_name // ""')
cwd=$(printf '%s' "$input" | jq -r '.cwd // ""')
[[ -n "$cwd" && -d "$cwd" ]] || cwd="$PWD"

candidates=()

case "$tool" in
    Write|Edit)
        fp=$(printf '%s' "$input" | jq -r '.tool_input.file_path // ""')
        [[ -n "$fp" ]] && candidates+=("$fp")
        ;;
    Bash)
        cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // ""')
        [[ -n "$cmd" ]] || exit 0
        # Every whitespace-delimited token ending in .bak. Over-collects on
        # purpose; the existence and freshness tests below do the real filtering.
        # The trailing (?=[^A-Za-z0-9]|$) equivalent is the [[:space:]...] class
        # below, so `foo.bakery` does not match as `foo.bak`.
        # NOTE: paths containing spaces are not captured. Backups of such files
        # must be cleaned by hand.
        while IFS= read -r tok; do
            [[ -n "$tok" ]] && candidates+=("$tok")
        done < <(printf '%s' "$cmd" | grep -oE "[^[:space:]'\"\`;|&<>()]+\.bak([[:space:]'\"\`;|&<>()]|\$)" || true)
        ;;
    *)
        exit 0
        ;;
esac

[[ ${#candidates[@]} -gt 0 ]] || exit 0

mkdir -p "$MANIFEST_DIR" 2>/dev/null || exit 0
manifest="$MANIFEST_DIR/${session_id}.txt"

for path in "${candidates[@]}"; do
    # Drop any trailing shell delimiter the match carried in, then strip
    # surrounding quotes a command line may have added.
    path="${path%%[[:space:]\'\"\`\;\|\&\<\>\(\)]}"
    path="${path%\"}"; path="${path#\"}"
    path="${path%\'}"; path="${path#\'}"

    [[ "$path" == *.bak ]] || continue

    # Resolve relative paths against the tool call's working directory.
    case "$path" in
        /*) abs="$path" ;;
        "~/"*) abs="$HOME/${path#\~/}" ;;
        *) abs="$cwd/$path" ;;
    esac

    # Only record something that actually exists now. This alone discards
    # `rm x.bak`, `cat x.bak` on a missing file, and typos.
    [[ -e "$abs" ]] || continue

    # Only record something created just now. This discards `ls *.bak`,
    # `cat old.bak`, and other reads of pre-existing backups.
    find "$abs" -maxdepth 0 -newermt "-${FRESH_SECONDS} seconds" >/dev/null 2>&1 || continue
    [[ -n "$(find "$abs" -maxdepth 0 -newermt "-${FRESH_SECONDS} seconds" 2>/dev/null)" ]] || continue

    # Normalise, then append only if not already listed.
    abs=$(readlink -m -- "$abs" 2>/dev/null || printf '%s' "$abs")
    if [[ -f "$manifest" ]] && grep -Fxq -- "$abs" "$manifest" 2>/dev/null; then
        continue
    fi
    printf '%s\n' "$abs" >> "$manifest"
done

exit 0
