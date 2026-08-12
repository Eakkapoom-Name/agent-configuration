---
name: subagent-delegation
description: Use when active instructions explicitly permit delegation and a task has independent, bounded research, implementation, or review work that benefits from a plan, delegated pass, and fresh-eyes verification.
---

# Subagent Delegation

Honor the current collaboration policy before spawning an agent. Do not delegate merely to avoid understanding the task, and do not delegate when active instructions prohibit or do not authorize it.

## Roles

- **Main**: Owns the task, scope, integration, and final answer.
- **Researcher**: Performs external or documentation research. Read-only. Return findings, direct sources, and uncertainty.
- **Builder**: Implements a specific approved slice. Do not expand scope or make architectural choices without reporting back.
- **Verifier**: Independently reviews the result against the original task and supplied artifact or diff. Do not provide the implementation rationale.
- **Explorer**: Locates code, call sites, ownership, and patterns. Keep read-only.

## Flow

1. Make a concrete plan and divide only genuinely independent work.
2. Give each agent a bounded objective, relevant paths or artifacts, constraints, and the expected return format.
3. Keep one owner per file or serialize overlapping edits.
4. Review agent results against the task and raw evidence. Resolve conflicts yourself.
5. Use a verifier for material changes when permitted, then run appropriate local checks before declaring completion.

Use the collaboration tools for delegation. Use `spawn_agent` only for a new independent task, `followup_task` for a completed agent's next bounded task, and `send_message` for context that does not require a new turn.
