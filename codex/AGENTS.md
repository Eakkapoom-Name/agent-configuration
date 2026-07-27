@/home/toaster/.codex/RTK.md

<goldenrule>
1. Never run `git reset --hard`, `git checkout .`, `git restore .`, or `git clean -fd`.
2. Ask for permission before any destructive Git operation.
3. To inspect or compare another revision, clone the repository to a unique directory under `/tmp` and work there.
4. To read an original tracked file, use `git show HEAD:<path>`.
5. Before overwriting an existing file, make a sibling `.bak` copy unless the task explicitly authorizes the overwrite or the edit is made with an auditable patch.
6. Preserve original code and logic unless the task explicitly requests a refactor. If the scope is ambiguous, ask first.
7. Before a non-trivial request, state the plan and interpretation, then obtain confirmation before implementation. The trivial-task exception below applies.
8. Freely create, edit, and delete task files under `/tmp` unless they could affect the system. Clean them up when the task is done; `/tmp` is not durable storage.
</goldenrule>

### Writing style

Never use em dashes in file edits, code, or chat responses. Use a period, comma, colon, or parentheses instead.

### Session communication mode

At the start of every new session, invoke the `caveman:caveman` skill in full mode. Keep it active for the rest of the session unless the user asks to stop caveman, switch modes, or clarity and safety require normal language.

### Git attribution

Never credit Codex, OpenAI, or an AI assistant as author, co-author, or contributor in commit messages, pull requests, release notes, or other repository content.

- Do not add `Co-Authored-By` trailers or generated-by lines.
- Before pushing, check that the commits being pushed contain no co-author trailers: `git log --format=%B origin/<branch>..HEAD | grep -ci "co-auth"` must return `0`.

### Trivial-task exception

Handle trivial tasks directly without plugin selection or the SDD lifecycle. Examples include a typo fix, summary, variable rename, comment tweak, or similarly small change.

This does not include project-level work or significant refactoring. A repeated cosmetic, non-semantic edit can remain trivial only when backed up first. A mechanical edit that changes behavior or meaning is non-trivial regardless of repetition. If uncertain, treat the task as non-trivial and ask first.

### Workflow skills

For non-trivial development work, use the `sdd-lifecycle` skill. For factual, current, or externally sourced claims, use the `verifying-facts` skill before searching or answering. Use `subagent-delegation` only when delegation is explicitly allowed by the active instructions.
