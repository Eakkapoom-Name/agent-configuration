# Secret Scanning Without Leaking Secrets (item 3 detail)

Confirm nothing sensitive leaked, without displaying the sensitive content
in the process. A naive `grep` that prints matched lines can itself leak
partial real secret values into the conversation transcript, putting the
exact thing you're checking for into the model's context and history.

## Rules

1. **Never print raw matched secret content.** Don't run `grep` (or
   equivalent) in a mode that echoes the matched line, file diff, or value.
2. **Use count-only or existence-check patterns instead:**
   - `grep -c PATTERN file` (count of matches, not the matches themselves).
   - `grep -q PATTERN file && echo found || echo clean` (boolean only).
   - `git log -p | grep -c PATTERN` for history scans, not `git log -p | grep PATTERN`.
3. **If you must scan a large diff or log**, redirect it to a temp file
   first (job/scratch dir, e.g. `$CLAUDE_JOB_DIR/tmp`, when running as a
   background job; `/tmp` otherwise), run count-only checks against it,
   then **delete the temp file** after (see goldenrule #8 for cleanup).
4. **Report results as a verdict, not evidence.** "Zero matches found for
   known secret patterns across N files", not a pasted partial credential.
5. If a genuine leak is found, report *that a match exists and where*
   (file + line number), not the matched value, let the user view it
   directly in their own editor/terminal.
