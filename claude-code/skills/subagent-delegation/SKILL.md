---
name: subagent-delegation
description: Describes the global subagents in ~/.claude/agents/ (researcher, builder, verifier), the built-in Explore agent, and the plan-delegate-verify flow between them. Use when dispatching work to subagents, delegating a task, or choosing which agent fits the work.
---

# Subagent Delegation

## Workflow

Multi-agent workflow, global subagents in `~/.claude/agents/`, available in every project:

- **Main** (no subagent). Inherits whichever model the main session is running (switched manually via `/model`). Understands the task, makes the plan, delegates to subagents, assembles the final result.
- **researcher** (sonnet). External lookups only: web search, docs, library/API references. Read-only, never edits. Returns findings + sources + search log.
- **builder** (sonnet). Writes/edits code strictly per Main's plan. No architecture changes or scope additions on its own; reports back instead of improvising if the plan is ambiguous or broken.
- **verifier** (inherit). Fresh-eyes review of the final output. Given only the original task statement and the resulting code/diff/output, never the plan or implementation reasoning. Reports correctness issues, gaps vs the task, edge cases.
- **Explore** (built-in). Codebase exploration/search. Use instead of a custom agent for "where is X" / "what calls Y" questions.

Flow: Main plans → researcher gathers external info when needed → builder implements per plan → verifier does a fresh-eyes review → Main declares the task done.
