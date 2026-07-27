---
name: sdd-lifecycle
description: Use when starting non-trivial software or product work to select and run the Spec, Critique, Refine, Implement, Verify lifecycle, including deciding whether an available workflow skill fits.
---

# Spec-Driven Development Lifecycle

Use this lifecycle for non-trivial greenfield and brownfield work:

Spec → Critique → Refine → Implement → Verify.

Do not skip a stage unless the user explicitly directs it. Respect the active `AGENTS.md` and developer instructions when they impose stricter limits.

## Start

1. State the interpretation, scope, assumptions, and proposed stage.
2. If the user has named a workflow or plugin, use it when available and compatible with the active instructions.
3. Otherwise, ask the user to choose before beginning non-trivial work:
   - Work directly for a bounded task that needs no specialized workflow.
   - Use a focused workflow skill for a medium or large task.
   - Use a persistent planning workflow, such as GSD, for very large work spanning sessions.
4. Do not begin implementation until the user confirms the intended approach and the spec is stable.

## Critique

Use `mattpocock-skills:grilling` for decisions, plans, product choices, and architecture. Ask one question at a time and wait for the user's decision. For codebase work, record durable project decisions in the repository's established documentation or ADR format when the user approves it.

## Implement and verify

Implement only the agreed scope. Treat an ambiguity or broken premise as a reason to return to Refine, not to invent scope. Verify each acceptance criterion with proportionate checks, then report the evidence and any remaining uncertainty.

## Delegation

Use a selected workflow's own delegation process first. Otherwise, invoke `subagent-delegation` only when subagents are explicitly permitted by the active instructions.
