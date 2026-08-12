---
name: sdd-workflow
description: Defines the user's Spec-Driven Development lifecycle (Spec, Critique, Refine, Implement, Verify), which grilling skill runs the Critique stage, the superpowers-versus-gsd plugin choice, and which subagents to delegate to. Use when starting any non-trivial greenfield or brownfield code/project task, before planning or writing code, and when deciding which SDD stage or plugin applies.
---

# SDD Lifecycle: My Development Workflow

I use Spec-Driven Development (SDD) for both greenfield (new code) and
brownfield (extending existing code) work.

### SDD lifecycle
Every SDD task follows the standard cycle:
Spec → Critique → Refine → Implement → Verify.
Do not skip stages unless I explicitly say so.

### Critique stage (grilling)
For the Critique step of the SDD lifecycle, always use `/grill-with-docs`
(mattpocock-skills' grilling), regardless of task type. Interview, also
captures resolved vocabulary as a `CONTEXT.md` glossary and hard one-way
decisions as ADRs along the way.
Interview one question at a time, my decision each time. Do not move to
Implement until I confirm the spec/plan is stable.

### Plugin selection (superpowers vs gsd)
These rules apply to all non-trivial tasks:

1. If I explicitly name which plugin to use, use that one. Period.
2. If I do NOT specify, ALWAYS ask me first before starting, using
   AskUserQuestion with exactly these three options:
   - No plugin (use Claude Code's built-in `/plan` directly, with
     subagent delegation)
   - superpowers
   - gsd
   Never pick one and start on your own, the final choice is mine.

### Subagent usage
- When working through superpowers or gsd: if that plugin ships its own
  subagents, use the plugin's agents. Only fall back to the
  subagent-delegation skill's agents for roles the plugin does not
  provide.
- For no-plugin tasks: use Claude Code's built-in `/plan`, then the
  subagent-delegation skill's agent flow for delegation.
