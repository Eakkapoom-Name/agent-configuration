# Agent Configuration

Shared AI agent configuration (rules, skills) for multiple coding assistants.

> **Note:** paths and config in this repo are from Zorin 18 (base from Ubuntu 24.04). Other
> distro or OS may use different paths or config locations.

## Installing Plugins

**Claude Code and Codex** both have a built-in TUI marketplace. Run:

``` bash
/plugins
```

then install by pasting the git repository URL you're
interested in.

**Antigravity** has no TUI marketplace. Install from the terminal directly:

``` bash
agy plugin install <repository-url>
```

### Recommended plugins to install for all agents
- **caveman:** https://github.com/JuliusBrussee/caveman.git
- **superpowers:** https://github.com/obra/superpowers.git
- **gsd:** https://github.com/open-gsd/gsd-core.git
- **mattpocock:** https://github.com/mattpocock/skills.git

### RTK
Install separately, follow the instructions on the RTK GitHub README directly.

- https://github.com/rtk-ai/rtk.git

>**Note:** For Antigravity, initialize rtk using `antigravity` instead of `gemini`, that is deprecated.

## Antigravity (Google Gemini)

Global rules file: `antigravity/GEMINI.md`\
Workflow reference file: `antigravity/sdd_workflow.md`\
Skills: `antigravity/skills/`

If you're setting up Google Antigravity (AGY) from this repo, give your agent this prompt:

```
Set up this repo's (agent-configuration) Antigravity config into my global
Antigravity config, interactively:

1. Ask me which rule sections from antigravity/GEMINI.md I want, as a
   multiple-choice list with a one-line description each:
   - Golden Rule (git safety: no destructive ops, ask before them, back up
     before overwrite, plan before non-trivial work)
   - Writing style (no em dashes)
   - Agent Isolation & Tooling Preference (keeps Antigravity from touching
     other agents' configs, fixes a known Antigravity cross-agent-bleed
     problem)
   - Plugin Source Verification (checks `agy plugin list` sources point to
     native ~/.gemini/ paths, fixes a known Antigravity misconfig problem)
   - Git attribution (no AI co-author trailers)
   - Trivial-task exception (defines what skips the plan-first gate)
   - SDD Workflow & Grilling Selection (spec-critique-refine-implement-verify
     lifecycle, needs the gsd plugin)
   - Caveman Mode (terse response style, needs the caveman plugin)
   - RTK (prefixes shell commands for token savings, needs the rtk CLI tool)
   Always list Agent Isolation & Tooling Preference and Plugin Source
   Verification as options even if I skip everything else, they exist to
   fix known Antigravity problems.

2. Merge only the sections I picked into ~/.gemini/GEMINI.md. If I picked
   SDD Workflow & Grilling Selection, also copy/merge
   antigravity/sdd_workflow.md -> ~/.gemini/sdd_workflow.md.

3. Then ask me which skills from antigravity/skills/ I want, as a
   multiple-choice list with a one-line description each: sdd-lifecycle,
   subagent-delegation, verifying-facts, verifying-facts-anecdote.
   If I pick verifying-facts-anecdote without verifying-facts, tell me it
   only works alongside verifying-facts (holds the rationale/rebuttals for
   it) and confirm before adding verifying-facts too.
   Copy each skill folder I confirm into ~/.gemini/antigravity/skills/ (or
   ~/.gemini/skills/).

4. For any rule section or skill that needs a plugin or tool (Caveman Mode
   -> caveman plugin, SDD Workflow -> gsd plugin, RTK -> rtk CLI tool):
   check if it's already installed (e.g. `agy plugin list`, `rtk
   --version`). If not found, ask me to confirm whether I already have it
   installed somewhere else or not. If I don't, tell me what to install and
   point me to that plugin/tool's own repository README.md, don't install
   it yourself.

Do not delete or overwrite any rules or skills I already have. If
~/.gemini/GEMINI.md already exists, append/merge only the sections I picked
without removing my existing content, ask me first if a merge isn't
straightforward. If a skill folder with the same name already exists
under ~/.gemini/, ask me before overwriting it.
```

>**Note on Caveman mode:** unlike Codex, Antigravity has no startup hook to
auto-invoke Caveman mode. It's fixed by adding the Caveman rule directly
into `GEMINI.md` (already done in this repo). Check `antigravity/GEMINI.md`
to see the rule.

## Structure

```
.antigravity/
├── GEMINI.md
├── sdd_workflow.md
└── skills/
    ├── sdd-lifecycle/
    │   └── SKILL.md
    ├── subagent-delegation/
    │   └── SKILL.md
    ├── verifying-facts/
    │   └── SKILL.md
    └── verifying-facts-anecdote/
        └── SKILL.md
```

## Codex

Global rules file: `codex/AGENTS.md`\
Skills: `codex/skills/`\
Startup hook: `codex/hooks.json`, install at `~/.codex/hooks.json`

`hooks.json` makes Caveman mode initialize on Codex session startup and resume.

If you're setting up Codex from this repo, give your agent this prompt:

```
Install this repo's (agent-configuration) Codex configuration into my
global Codex config, interactively:

1. Ask me which rule sections from codex/AGENTS.md I want, as a
   multiple-choice list with a one-line description each:
   - Golden Rule (git safety: no destructive ops, ask before them, back up
     before overwrite, plan before non-trivial work)
   - Writing style (no em dashes)
   - Session communication mode (invokes the caveman skill in full mode at
     session start, needs the caveman plugin and its SessionStart hook)
   - Git attribution (no AI co-author trailers)
   - Trivial-task exception (defines what skips the plan-first gate)
   - Workflow skills (points AGENTS.md at sdd-lifecycle, verifying-facts,
     subagent-delegation)
   Note AGENTS.md also always imports RTK.md
   (@/home/<user-system-name>/.codex/RTK.md), unconditional, not a pickable section,
   check step 4 for its prerequisite.

2. Merge only the sections I picked into ~/.codex/AGENTS.md. If I picked
   Session communication mode, also merge the Caveman SessionStart hook
   from codex/hooks.json into ~/.codex/hooks.json, tell me the caveman
   skill alone won't auto-invoke without this hook.

3. Then ask me which skills from codex/skills/ I want, as a multiple-choice
   list with a one-line description each: hardcode-secret, sdd-lifecycle,
   security-scan, subagent-delegation, verifying-facts,
   verifying-facts-anecdote.
   If I pick security-scan without hardcode-secret, tell me security-scan
   delegates its secret-check step to hardcode-secret and won't work
   without it, confirm before adding hardcode-secret too.
   If I pick verifying-facts-anecdote without verifying-facts, tell me it
   only works alongside verifying-facts (holds the rationale/rebuttals for
   it) and confirm before adding verifying-facts too.
   Copy each skill folder I confirm into ~/.codex/skills/.

4. For anything that needs a plugin or tool (Session communication mode ->
   caveman plugin, RTK.md import -> rtk CLI tool): check if it's already
   installed. If not found, ask me to confirm whether I already have it
   installed somewhere else or not. If I don't, tell me what to install and
   point me to that plugin/tool's own repository README.md, don't install
   it yourself.

Do not delete, replace, or remove any rules, skills, hooks, or other
configuration I already have. Add only what I picked. If any destination
file or skill folder already exists and a safe merge is not
straightforward, stop and ask me before changing it. Do not overwrite an
existing skill folder or hooks configuration without my approval.
```

## Structure

```
.codex/
├── AGENTS.md
├── hooks.json
└── skills/
    ├── hardcode-secret/
    │   ├── SKILL.md
    │   └── agents/
    │       └── openai.yaml
    ├── sdd-lifecycle/
    │   ├── SKILL.md
    │   └── agents/
    │       └── openai.yaml
    ├── security-scan/
    │   ├── SKILL.md
    │   ├── agents/
    │   │   └── openai.yaml
    │   └── references/
    │       └── remediation.md
    ├── subagent-delegation/
    │   ├── SKILL.md
    │   └── agents/
    │       └── openai.yaml
    ├── verifying-facts/
    │   ├── SKILL.md
    │   └── agents/
    │       └── openai.yaml
    └── verifying-facts-anecdote/
        ├── SKILL.md
        └── agents/
            └── openai.yaml
```

## Claude Code

Global rules file: `claude-code/CLAUDE.md`\
Skills: `claude-code/skills/`

If you're setting up Claude Code from this repo agent-configuration , give your agent this prompt:

```
Set up this repo's (agent-configuration) Claude Code config into my global
Claude Code config, interactively:

1. Ask me which rule sections from claude-code/CLAUDE.md I want, as a
   multiple-choice list with a one-line description each:
   - Golden Rule (git safety: no destructive ops, ask before them, back up
     before overwrite, plan before non-trivial work)
   - Writing style (no em dashes)
   - Git attribution (no AI co-author trailers)
   - Trivial-task exception (defines what skips the plan-first gate)
   Note CLAUDE.md also always imports RTK.md (@RTK.md), unconditional, not
   a pickable section, check step 4 for its prerequisite.

2. Merge only the sections I picked into ~/.claude/CLAUDE.md.

3. Then ask me which skills from claude-code/skills/ I want, as a
   multiple-choice list with a one-line description each: hardcode-secret,
   sdd-lifecycle, security-scan, subagent-delegation, verifying-facts,
   verifying-facts-anecdote.
   If I pick security-scan without hardcode-secret, tell me security-scan
   delegates its secret-check step to hardcode-secret and won't work
   without it, confirm before adding hardcode-secret too.
   If I pick verifying-facts-anecdote without verifying-facts, tell me it
   only works alongside verifying-facts (holds the rationale/rebuttals for
   it) and confirm before adding verifying-facts too.
   Copy each skill folder I confirm into ~/.claude/skills/.

4. RTK.md is always imported by CLAUDE.md: check if the rtk CLI tool is
   already installed (`rtk --version`). If not found, ask me to confirm
   whether I already have it installed somewhere else or not. If I don't,
   tell me what to install and point me to the rtk repository's own
   README.md, don't install it yourself.

Do not delete or overwrite any rules or skills I already have. If
~/.claude/CLAUDE.md already exists, append/merge only the sections I picked
without removing my existing content, ask me first if a merge isn't
straightforward. If a skill folder with the same name already exists
under ~/.claude/skills/, ask me before overwriting it.
```

## Structure

```
.claude/
    ├── CLAUDE.md
    └── skills/
        ├── hardcode-secret/
        │   └── SKILL.md
        ├── sdd-lifecycle/
        │   └── SKILL.md
        ├── security-scan/
        │   ├── SKILL.md
        │   └── references/
        │       └── remediation.md
        ├── subagent-delegation/
        │   └── SKILL.md
        ├── verifying-facts/
        │   └── SKILL.md
        └── verifying-facts-anecdote/
            └── SKILL.md
```
