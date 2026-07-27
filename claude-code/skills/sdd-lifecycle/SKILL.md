---
name: sdd-lifecycle
description: Use when starting a non-trivial task and picking the SDD stage or plugin (superpowers vs gsd), Spec-Critique-Refine-Implement-Verify lifecycle.
---

## My Development Workflow (SDD)

I use Spec-Driven Development (SDD) for both greenfield (new code) and
brownfield (extending existing code) work.

### SDD lifecycle
Every SDD task follows the standard cycle:
Spec → Critique → Refine → Implement → Verify.
Do not skip stages unless I explicitly say so.

### Critique stage (grilling)
For the Critique step of the SDD lifecycle, use mattpocock-skills' grilling,
split by task type:
- Non-code decisions (plans, product/design choices, anything without a
  codebase artifact): `/grill-me` (or let `grilling` auto-trigger on grill
  phrases). Plain interview, no paper trail.
- Coding tasks (codebase feature planning, technical architecture):
  `/grill-with-docs`. Same interview, also captures resolved vocabulary as
  a `CONTEXT.md` glossary and hard one-way decisions as ADRs along the way.
Interview one question at a time, my decision each time. Do not move to
Implement until I confirm the spec/plan is stable.

### Plugin selection (superpowers vs gsd)
These rules apply to all non-trivial tasks:

1. If I explicitly name which plugin to use, use that one. Period.
2. If I do NOT specify, ALWAYS ask me first before starting.
3. If I say I'm not sure, analyze the scope of the task first, then
   present me a recommendation with these tiers, and let me choose:
   - No plugin needed → work directly
   - Medium to large task → use superpowers
   - Very large / complex task spanning multiple sessions → use gsd
   Never pick a tier and start on your own, the final choice is mine.

### Subagent usage
- When working through superpowers or gsd: if that plugin ships its own
  subagents, use the plugin's agents. Only fall back to the
  subagent-delegation skill's agents for roles the plugin does not
  provide.
- For no-plugin tasks: use the subagent-delegation skill's agent flow
  directly.
