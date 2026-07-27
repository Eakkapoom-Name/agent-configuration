# agent-configuration

Shared AI agent configuration (rules, skills) for multiple coding assistants.

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

.codex/
├── AGENTS.md
├── RTK.md
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

## Antigravity (Google Gemini)

Global rules file: `antigravity/GEMINI.md`
Workflow reference file: `antigravity/sdd_workflow.md`
Skills: `antigravity/skills/`

If you're setting up Google Antigravity (AGY) from this repo, give your agent this prompt:

```
Copy the rules and skills from this repo's (agent-configuration) antigravity/ folder into my
Antigravity global config:

- antigravity/GEMINI.md -> merge into ~/.gemini/GEMINI.md
- antigravity/sdd_workflow.md -> copy/merge into ~/.gemini/sdd_workflow.md
- antigravity/skills/* -> copy each skill folder into ~/.gemini/antigravity/skills/ (or ~/.gemini/skills/)

Do not delete or overwrite any rules or skills I already have. If
~/.gemini/GEMINI.md already exists, append/merge these rules into it
without removing my existing content, ask me first if a merge isn't
straightforward. If a skill folder with the same name already exists
under ~/.gemini/, ask me before overwriting it.
```

## Claude Code

Global rules file: `claude-code/CLAUDE.md`
Skills: `claude-code/skills/`

If you're setting up Claude Code from this repo agent-configuration , give your agent this prompt:

```
Copy the rules and skills from this repo's (agent-configuration) claude-code/ folder into my
Claude Code global config:

- claude-code/CLAUDE.md -> merge into ~/.claude/CLAUDE.md
- claude-code/skills/* -> copy each skill folder into ~/.claude/skills/

Do not delete or overwrite any rules or skills I already have. If
~/.claude/CLAUDE.md already exists, append/merge these rules into it
without removing my existing content, ask me first if a merge isn't
straightforward. If a skill folder with the same name already exists
under ~/.claude/skills/, ask me before overwriting it.
```

## Codex

Global rules file: `codex/AGENTS.md`
Skills: `codex/skills/`
Startup hook: `codex/hooks.json`, install at `~/.codex/hooks.json`

`hooks.json` makes Caveman mode initialize on Codex session startup and resume.

If you're setting up Codex from this repo, give your agent this prompt:

```
Install this repo's (agent-configuration) Codex configuration into my global Codex config:

- codex/AGENTS.md -> merge into ~/.codex/AGENTS.md
- codex/skills/* -> copy each skill folder into ~/.codex/skills/
- codex/hooks.json -> merge the Caveman SessionStart hook into ~/.codex/hooks.json

Do not delete, replace, or remove any rules, skills, hooks, or other
configuration I already have. Add only this repo's rules and skills. If
any destination file or skill folder already exists and a safe merge is
not straightforward, stop and ask me before changing it. Do not overwrite
an existing skill folder or hooks configuration without my approval.
```
