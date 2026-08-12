# Codex Delegation

- **codex-plugin-cc:** https://github.com/openai/codex-plugin-cc.git

## What it does

Lets Claude Code delegate work to Codex. Why? GPT models are cheaper
per token than Claude models, so the split is Claude plans, delegates,
and reviews (finds bugs/security issues), Codex implements and debugs.
Claude is careful, methodical, and cautious, strong at planning and
security review. GPT is stronger at raw coding and agentic execution.
Combining them cuts spend a lot since expensive Claude tokens aren't
burned on implementation. See intelligence-per-cost benchmarks e.g. https://deepswe.datacurve.ai (most trustable benchmark for now) or other
SWE-bench-style leaderboards if you want the numbers behind this.

## Setup

1. Install Codex CLI if you don't have it:

```bash
curl -fsSL https://chatgpt.com/codex/install.sh | sh
```

2. Run `codex` in a terminal, and sign in. (Skip 1-2 if Codex is already set up.)

```bash
codex
```

3. Run `claude` in a terminal.

```bash
claude
```

4. Run `/codex:setup` in claude code.

```
/codex:setup
```

5. You should see `Codex ready.` and you're done. If it errors, follow the
   error's own fix instructions.

## How to use

**Planning**: use Fable 5 low-high if available, otherwise Opus 5
low-high depending on budget. High effort recommended for planning.

**Delegating**: use Opus 5 low or Sonnet 5 low-medium, with Opus 5 as
advisor via `/advisor`. The advisor call costs more tokens but pushes
Sonnet's output close to Opus quality at lower overall cost than running
Opus directly.

**Bug hunting / security review**: same tier as planning (Fable/Opus 5
high). Opus is more detail-oriented and intelligent, better for
large-scale bug resolution and troubleshooting security issues. Fable is
strong on the big picture, good for the initial hunt across a large
surface.

**A common flow:** Fable hunts for bugs/vulnerabilities, Opus
troubleshoots the specific problem, Codex implements the fix.

**Delegating implementation to Codex**: tell Claude directly in the
prompt, for example:

```
I want you to be a planner, delegator, and
reviewer, but not an implementer. Codex will implement the code using
GPT 5.6 Lunar max.
```

Use high, xhigh, or max effort (max recommended).

**Fixing bugs/security risk via Codex**: tell Claude to have Codex fix it
with GPT 5.6 Lunar max or GPT 5.6 Sol high. Both are cost-effective on
intelligence-per-cost. Sol is more capable and more costly than Lunar,
comparable to the Opus/Sonnet cost gap. Use Lunar high-max or Sol
low-high depending on the situation.

---
See also: [README](../README.md)
