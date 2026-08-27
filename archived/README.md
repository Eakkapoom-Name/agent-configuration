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

**Hermes** has no TUI marketplace. Enable plugins via `~/.hermes/config.yaml` `plugins.enabled` list (see `hermes/README.md` and `hermes/config.yaml.example`).

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
Prompt file: `claude-code/RTK.md`, imported unconditionally by CLAUDE.md (`@RTK.md`)\
Skills: `claude-code/skills/`\
Agents: `claude-code/agents/`, install at `~/.claude/agents/`\
Hooks: `claude-code/hooks/`, scripts install at `~/.claude/hooks/`, register via
`claude-code/hooks/settings-snippet.json` merged into `~/.claude/settings.json`

`block-em-dash.sh` enforces the no-em-dash writing-style rule at the file-edit
level (PreToolUse) instead of relying on memory alone. `verify-facts-reminder.sh`
backs the verifying-facts skill with a standing per-turn reminder (UserPromptSubmit),
since skill-description auto-triggering isn't reliable once many skills are
installed. `bak-manifest-record.sh` + `bak-manifest-session.sh` track `.bak`
files created in a session so the session-cleanup skill knows what it may
delete.

The three agents (`researcher`, `builder`, `verifier`) are the global subagent
flow the subagent-delegation skill describes: Main plans, researcher gathers
external info, builder implements per plan, verifier does a fresh-eyes review.

**Bundled pieces** (pick one, get all): each of these is written to work
together and is broken without the rest.
- **workflow bundle**: CLAUDE.md's Trivial-task exception section (its
  greenfield/brownfield gate names sdd-workflow) + sdd-workflow skill +
  subagent-delegation skill + the 3 agents (`researcher`/`builder`/`verifier`).
- **cleanup bundle**: session-cleanup skill + `bak-manifest-record.sh` +
  `bak-manifest-session.sh` hooks.
- **facts bundle**: verifying-facts skill + `verify-facts-reminder.sh` hook.

If you're setting up Claude Code from this repo agent-configuration , give your agent this prompt:

```
Set up this repo's (agent-configuration) Claude Code config into my global
Claude Code config, interactively:

0. First, tell me about the three bundles (workflow, cleanup, facts, see
   the repo README's "Bundled pieces" note) before asking anything else,
   so I know picking one item from a bundle means the whole bundle
   installs together. Keep this in mind for every step below, whenever I
   pick anything from a bundle, don't ask about the rest of that bundle
   piece by piece, just confirm once that you're adding the full bundle
   and proceed. If I explicitly say I only want a partial bundle, warn me
   it's not designed to work standalone, then respect my choice.

1. Ask me which rule sections from claude-code/CLAUDE.md I want, as a
   multiple-choice list with a one-line description each:
   - Golden Rule (git safety: no destructive ops, ask before them, back up
     before overwrite, plan before non-trivial work)
   - Git attribution (no AI co-author trailers)
   - Trivial-task exception (optional, workflow bundle: defines what
     skips the plan-first gate, and when to interactively ask about the
     sdd-workflow skill for greenfield/brownfield code work; picking it
     also pulls in sdd-workflow, subagent-delegation, and the 3 agents
     from steps 3-4)
   Note CLAUDE.md also always imports RTK.md (@RTK.md), unconditional, not
   a pickable section, check step 6 for its prerequisite. Writing style
   (no em dashes) is not a rule-text section anymore, it's enforced by the
   block-em-dash hook instead, see step 5.

2. Merge only the sections I picked into ~/.claude/CLAUDE.md.

3. Then ask me which skills from claude-code/skills/ I want, as a
   multiple-choice list with a one-line description each: sdd-workflow
   (optional, workflow bundle, needs the superpowers, gsd, and
   mattpocock-skills plugins installed, see Installing Plugins above,
   check step 7 for verification), security-scan (optional, standalone),
   session-cleanup (optional, cleanup bundle), subagent-delegation
   (optional, workflow bundle), verifying-facts (optional, facts bundle).
   If I pick Trivial-task exception in step 1, or any workflow-bundle
   skill, or any of the 3 agents in step 4, install sdd-workflow and
   subagent-delegation together, don't split them.
   Copy each skill folder I confirm into ~/.claude/skills/.

4. Then ask me which agents from claude-code/agents/ I want, as a
   multiple-choice list with a one-line description each: researcher
   (optional, workflow bundle, external lookups, read-only), builder
   (optional, workflow bundle, implements a plan Main gives it), verifier
   (optional, workflow bundle, fresh-eyes review, no prior context on the
   plan). All three are the workflow bundle together with sdd-workflow and
   subagent-delegation, if I pick any one of these five workflow-bundle
   items anywhere in steps 1, 3, or 4, install all five.
   Copy each agent file I confirm into ~/.claude/agents/.

5. Then ask me which hooks from claude-code/hooks/ I want, as a
   multiple-choice list with a one-line description each: block-em-dash
   (optional, standalone, no em dashes, PreToolUse, needs `jq` installed),
   verify-facts-reminder (optional, facts bundle, with verifying-facts,
   needs `jq` installed), bak-manifest-record and bak-manifest-session
   (optional, cleanup bundle, with session-cleanup, needs `jq` installed).
   If I picked verifying-facts in step 3, install verify-facts-reminder.sh
   too without asking again, and vice versa. Same for session-cleanup and
   the bak-manifest-*.sh pair.
   Copy each script I confirm into ~/.claude/hooks/, then merge its entry
   from claude-code/hooks/settings-snippet.json into ~/.claude/settings.json
   (merge the hooks object, don't overwrite my existing hooks config).

6. RTK.md is always imported by CLAUDE.md: check if the rtk CLI tool is
   already installed (`rtk --version`). If not found, ask me to confirm
   whether I already have it installed somewhere else or not. If I don't,
   tell me what to install and point me to the rtk repository's own
   README.md, don't install it yourself.

7. For anything else that needs a plugin or tool beyond RTK:
   - If I picked sdd-workflow (or its workflow bundle): check whether the
     superpowers, gsd, and mattpocock-skills plugins are installed (e.g.
     `/plugins` list, or ask me). Any missing, tell me it's needed for
     sdd-workflow's plugin-selection step and grilling step respectively,
     point me to the Installing Plugins section above, don't install it
     yourself.
   - If I picked any hook in step 5: check whether `jq` is installed
     (`jq --version`). If not found, tell me the hooks won't work without
     it and point me to jq's own install instructions, don't install it
     yourself.

Do not delete or overwrite any rules, skills, agents, or hooks I already
have. If ~/.claude/CLAUDE.md or ~/.claude/settings.json already exists,
append/merge only the sections I picked without removing my existing
content, ask me first if a merge isn't straightforward. If a skill folder,
agent file, or hook script with the same name already exists, ask me
before overwriting it.
```

### Updating a stale install

If you already installed an older version of this repo's Claude Code config
(e.g. `~/.claude/skills/hardcode-secret`, `~/.claude/skills/sdd-lifecycle`, or
`~/.claude/skills/verifying-facts-anecdote` exist, or `~/.claude/CLAUDE.md`
still has a "Writing style (no em dashes)" section, or `~/.claude/hooks/`
has none of this repo's scripts), give your agent this prompt instead:

```
Update my existing Claude Code config to match this repo's (agent-configuration)
current claude-code/ state, interactively:

0. First, tell me about the three bundles (workflow, cleanup, facts, see
   the repo README's "Bundled pieces" note). While going through steps
   1-4 below, if you find I have some but not all of a bundle's pieces,
   flag the gap and ask if I want to complete the bundle, don't silently
   leave it partial.

1. Diff claude-code/CLAUDE.md against ~/.claude/CLAUDE.md. Show me what
   changed section by section (the em-dash rule text was removed, it's now
   hook-enforced; the Trivial-task exception section was reworked to add
   the sdd-workflow interactive-ask gate for greenfield/brownfield code
   work). Ask me to confirm before merging each changed section, don't
   silently overwrite my existing wording if I've customized it.

2. Diff claude-code/skills/ against ~/.claude/skills/:
   - Skills present in the repo but missing locally (sdd-workflow,
     session-cleanup, or others added since your last sync): ask if I want
     to add each one.
   - Skills present locally but renamed/removed in the repo
     (sdd-lifecycle renamed to sdd-workflow; hardcode-secret merged into
     security-scan's references/secret-scanning.md, no longer a separate
     skill; verifying-facts-anecdote removed, its content was folded out
     of verifying-facts): explain the rename/merge/removal for each, ask
     me to confirm before deleting the stale folder and (for renames)
     copying in the new one.
   - Skills present in both: diff SKILL.md and any references/ files, ask
     me to confirm before overwriting if content differs.
   Never delete a locally-modified skill folder without showing me the
   diff and getting explicit confirmation first.
   Workflow bundle check: if I have sdd-workflow or subagent-delegation but
   not the other, or I have either but none of the 3 agents from step 3,
   flag it and ask if I want to complete the bundle.
   Cleanup bundle check: if I have session-cleanup but not both
   bak-manifest hooks (step 4), or vice versa, flag it the same way.
   Facts bundle check: if I have verifying-facts but not
   verify-facts-reminder.sh (step 4), or vice versa, flag it the same way.

3. Check ~/.claude/agents/ against claude-code/agents/: for any agent
   missing locally (researcher, builder, verifier), ask if I want to add
   it. These 3 agents are part of the workflow bundle with sdd-workflow
   and subagent-delegation, if I have any workflow-bundle piece but not
   all 5, flag it and ask if I want to complete the bundle rather than
   asking about each agent in isolation. For agents present in both, diff
   and ask before overwriting if content differs.

4. Check ~/.claude/hooks/ against claude-code/hooks/: for any script
   missing locally (block-em-dash.sh, verify-facts-reminder.sh,
   bak-manifest-record.sh, bak-manifest-session.sh), ask if I want to add
   it. verify-facts-reminder.sh is the facts bundle with verifying-facts,
   and bak-manifest-record.sh plus bak-manifest-session.sh are the cleanup
   bundle with session-cleanup, if I have the skill side of either bundle
   but not its hook(s) (or the reverse), offer to complete the bundle
   rather than asking about each script alone. If I confirm any, merge the
   corresponding entries from claude-code/hooks/settings-snippet.json into
   my ~/.claude/settings.json hooks object, don't overwrite unrelated
   hooks I already have configured there. Validate the merged
   settings.json is still valid JSON afterward.

5. Check if claude-code/RTK.md differs from my ~/.claude/RTK.md (if I have
   one). If it does, show the diff and ask before overwriting.

Back up any file before overwriting it (goldenrule: cp file file.bak).
Ask me before every destructive step (delete, overwrite). If anything is
ambiguous, stop and ask rather than guessing my intent.
```

## Structure

```
.claude/
    ├── CLAUDE.md
    ├── RTK.md
    ├── agents/
    │   ├── researcher.md
    │   ├── builder.md
    │   └── verifier.md
    ├── hooks/
    │   ├── block-em-dash.sh
    │   ├── verify-facts-reminder.sh
    │   ├── bak-manifest-record.sh
    │   ├── bak-manifest-session.sh
    │   └── settings-snippet.json
    └── skills/
        ├── sdd-workflow/
        │   └── SKILL.md
        ├── security-scan/
        │   ├── SKILL.md
        │   └── references/
        │       ├── remediation.md
        │       └── secret-scanning.md
        ├── session-cleanup/
        │   └── SKILL.md
        ├── subagent-delegation/
        │   └── SKILL.md
        └── verifying-facts/
            └── SKILL.md
```

## Hermes Agent

Global rules file: `hermes/SOUL.md` (always-loaded, every Hermes session, any cwd) \
Config: `hermes/config.yaml.example` (sanitized, copy to `~/.hermes/config.yaml`) \
Skills: `hermes/skills/` (placeholder, live skills in `~/.hermes/skills/`) \
Plugins: `caveman-autostart`, `superpowers`, `gsd-core`, `rtk-rewrite`, `web/tavily`, `platforms/line`, etc (see `hermes/config.yaml.example`)

Isolation: Hermes reads `~/.hermes/SOUL.md` + `~/.hermes/config.yaml` only. No `~/AGENTS.md` spill. Codex (`~/.codex/`) and Claude (`~/.claude/`) untouched. SOUL.md migrates old `~/AGENTS.md` goldenrule into always-load.

`caveman-autostart` injects Caveman Full mode via `pre_llm_call` hook every turn (disable: `touch ~/.hermes/.caveman-disabled` or say "stop caveman").

If setting up Hermes from this repo, give agent this prompt:

```
Set up this repo's (agent-configuration) Hermes config into my global
Hermes config, interactively:

1. Ask which rule sections from hermes/SOUL.md I want, as multiple-choice
   with one-line description each:
   - Golden Rule (git safety: no destructive ops, ask before them, back up
     before overwrite, plan before non-trivial work)
   - Writing style (no em dashes, hook-enforced)
   - Git attribution (no AI co-author trailers, multi-model)
   - Trivial-task exception (defines what skips plan-first gate)
   - SDD Workflow gate (spec-critique-refine-implement-verify, needs
     superpowers/gsd plugins)
   - RTK (prefix shell commands for token savings, needs rtk CLI)
   Note SOUL.md also has Hermes identity header, always loaded.

2. Merge only sections I picked into ~/.hermes/SOUL.md.
   SOUL.md is always-loaded (every Hermes session, any cwd), unlike
   ~/.hermes/AGENTS.md which only loads when cwd is ~/.hermes.

3. Then ask about config from hermes/config.yaml.example:
   - model/provider (default muse-spark via opencode-free)
   - plugins.enabled list (caveman-autostart, superpowers, gsd-core,
     rtk-rewrite, web/tavily, platforms/line, etc)
   - display/personality (concise), reasoning_effort, timezone
   Merge only confirmed keys into ~/.hermes/config.yaml, do not
   overwrite existing secrets (api_key, auth.json).

4. For any section needing plugin/tool (caveman -> caveman-autostart,
   SDD Workflow -> superpowers/gsd-core, RTK -> rtk CLI):
   check if installed (hermes plugins list, rtk --version).
   If missing, point to repo URL, do not install silently.

Do not delete rules/skills/plugins I already have. If ~/.hermes/SOUL.md
or config.yaml exists, append/merge only picked sections, ask if merge
not straightforward. If skill/plugin with same name exists, ask before
overwriting.
```

## Structure

```
.hermes/
├── SOUL.md              # always-loaded global rules (9.3K)
├── config.yaml          # model, provider, plugins, display (12K)
└── skills/              # skills live in ~/.hermes/skills/ (curator-managed)
    ├── superpowers/     # sdd-workflow, brainstorming, systematic-debugging
    ├── productivity/    # caveman, session-cleanup
    ├── verifying-facts/ # fact-checking
    └── ... (see hermes/skills/README.md)
```
