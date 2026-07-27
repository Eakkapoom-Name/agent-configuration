<goldenrule>
1. NEVER run: git reset --hard, git checkout ., git restore ., git clean -fd
2. ALWAYS ask permission before any destructive git operation
3. If you need to checkout/compare: clone to /tmp and do it there
4. If you need the original file: use `git show HEAD:filename`
5. Back up before overwrite: cp file file.bak
6. IMPORTANT: Try to preserve original code and logic as much as
   possible, unless the task is explicitly a refactor. If unsure
   whether it's a refactor task, ask me first.
7. Before acting on any non-trivial request, state your plan/interpretation.
   Don't jump straight to execution but ask me first. (Trivial-task exception
   below still applies; see sdd-lifecycle skill for the full lifecycle this
   gate feeds into.)
8. Freely create, edit, delete files in `/tmp` without asking, unless a
   file could affect or break my system (ask first then). Not wiped on
   restart; swept by `systemd-tmpfiles-clean.timer` after 30 days of no
   access, so nothing there is durable long-term. Clean up files when a
   job's done; keep them only if still needed next session.
</goldenrule>

### Writing style
Never use em dashes (—) in file edits, code, or chat responses. Use a
period, comma, or parentheses instead.

### Git attribution
Never credit Claude as author, co-author, or contributor on my GitHub.
- No `Co-Authored-By: Claude ...` (any casing/model name) trailer in any
  commit message, and no "Generated with Claude Code" line in commit
  messages, PR bodies, or release notes. This overrides Claude Code's
  default trailer behavior.
- Squash-merge gotcha: GitHub squash merges concatenate branch commit
  messages into the merge commit and auto-credit any co-author found
  there. Keeping every branch commit trailer-free is what prevents this.
- Check before every push: `git log --format=%B origin/<branch>..HEAD |
  grep -ci "co-auth"` must return 0.
Why: co-author trailers put Claude in the repo's GitHub contributors
list; I want sole authorship, and scrubbing later needs a history
rewrite plus force-push (already had to do this once).

### Trivial task exception
Trivial tasks are exempt from the plugin-selection question and the
SDD lifecycle, just do them directly, no need to ask. Trivial means
things like: fixing a typo, writing a summary, renaming a variable,
tweaking a comment, or other very small changes of similar scope.
It does NOT include anything project-level or significant refactoring,
those are real tasks and must go through the SDD lifecycle (see
sdd-lifecycle skill). Multi-file is not automatically non-trivial, but the
carve-out is narrow: the same edit repeated identically across many files
stays trivial only if it's purely cosmetic/non-semantic (formatting,
punctuation, whitespace) AND backed up first. A mechanical edit that
changes behavior or meaning (e.g. a global find/replace of an identifier
that alters what code does) is non-trivial regardless of how repetitive
it is. If unsure whether a task is trivial, treat it as non-trivial and
ask me first.

@RTK.md
