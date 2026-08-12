---
name: session-cleanup
description: Removes the .bak backup files created during this session, using the per-session manifest written by the bak-manifest hooks. Use when I say "let's end this session", "end the session", "we're done", "wrap up", "clean files before we end", or otherwise indicate work is finished for now.
---

# Session Cleanup: remove this session's .bak files

Golden rule 5 says back up before overwrite, so a working session leaves `.bak`
files scattered next to the originals. Once the work is verified, they are
clutter. Clean them at session end.

### How this session's .bak files are tracked

Two hooks maintain the record, so I never have to guess or rely on remembering:

- `~/.claude/hooks/bak-manifest-session.sh` (SessionStart) tells me this
  session's id and manifest path via `additionalContext`.
- `~/.claude/hooks/bak-manifest-record.sh` (PostToolUse on Bash/Write/Edit)
  appends every freshly-created `.bak` to
  `~/.claude/bak-manifest/<session_id>.txt`.

The recorder only logs a path that exists and was modified in the last 120
seconds, so reads of old backups (`cat x.bak`, `ls *.bak`) and deletes
(`rm x.bak`) never enter the manifest.

**The manifest is the authority on what may be deleted.** Do not run a broad
`find` for `*.bak`. Do not delete a path that is not listed in it. The blast
radius of a wrong delete here is someone's only copy of a file.

### Guard: do not clean broken work

Before deleting anything, check the state of the session's work. Keep the `.bak`
files and explain why if any of these are true:

- A test, build, lint, or syntax check failed and was not subsequently fixed
- An edit was abandoned partway, or a task was left blocked
- A file was changed but never run or verified
- The user has an unanswered question pending about the changed code

A `.bak` is the recovery path for a broken edit. When the live file is the bad
copy, the backup is the *only* good copy, and deleting it is the one move that
cannot be undone. Verified work first, cleanup second.

### Procedure

1. Read `~/.claude/bak-manifest/<session_id>.txt` for the current session id
   (given to me at SessionStart). If the file does not exist, no backups were
   made. Say so, no-op, not an error.
2. Drop any listed path that no longer exists, it was already cleaned.
3. Run the guard above. If it trips, stop, keep the files, say which check
   failed and what would need to pass to clean them.
4. Show the list of paths to be deleted, then **ask for confirmation and wait**.
   Do not delete before the user answers.
5. On approval, delete the listed files, then remove the manifest itself.
6. Report what was removed and confirm the originals are still in place.

### Stale manifests from earlier sessions

Other `<session_id>.txt` files in `~/.claude/bak-manifest/` are sessions that
ended without cleanup. Mention that they exist and offer to show them, but
**never delete stale manifests or their .bak files automatically.** Those
backups stay until the user explicitly asks, in a separate confirmed step.

### Known limitation

The recorder tokenises commands on whitespace, so a backup whose path contains
a space is not captured. If I created one, I have to clean it by hand and say
so, it will not be in the manifest.

### Ending report

Cleanup is part of the end-of-session report, not a replacement for it. Still
state what changed, where it lives, what was verified, and what was left
untested or deliberately skipped.
