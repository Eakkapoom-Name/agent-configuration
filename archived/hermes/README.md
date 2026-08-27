# Hermes Agent

Hermes Agent global config (rules, skills, plugins) archived from `~/.hermes/`.

> **Note:** paths from Zorin 18 (Ubuntu 24.04). Other OS use different paths.

Global rules file: `hermes/SOUL.md` (always-loaded, every session, any cwd) \
Config: `hermes/config.yaml.example` (sanitized, copy to `~/.hermes/config.yaml`) \
Skills: `hermes/skills/` (placeholder, see `~/.hermes/skills/`) \
Plugins: enabled list in `config.yaml.example` (`caveman-autostart`, `superpowers`, `gsd-core`, `rtk-rewrite`, etc)

Isolation: Hermes reads `~/.hermes/SOUL.md` and `~/.hermes/config.yaml` only. No `~/AGENTS.md` spill. Codex (`~/.codex/`) and Claude (`~/.claude/`) untouched.

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
   check if installed (`hermes plugins list`, `rtk --version`).
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
    └── ... (see skills/README.md)
```

Plugins enabled (example): `caveman-autostart`, `superpowers`, `gsd-core`, `mattpocock-skills`, `rtk-rewrite`, `web/tavily`, `platforms/line`.

Disable caveman: `touch ~/.hermes/.caveman-disabled` or say "stop caveman".
