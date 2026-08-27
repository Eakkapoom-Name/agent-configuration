# Hermes skills

Hermes skills live in `~/.hermes/skills/` (managed by curator, not archived verbatim).

Top categories (from live `~/.hermes/skills/`):

- `superpowers/` - brainstorming, writing-plans, executing-plans, systematic-debugging, test-driven-development, etc
- `productivity/` - caveman, session-cleanup
- `software-development/` - sdd-workflow, verifying-facts, requesting-code-review
- `github/` - codebase-inspection, github-pr-workflow
- `research/` - arxiv, grounded-citations
- `creative/` - architecture-diagram, ascii-art
- `mlops/`, `data-science/`, `media/`, `hermes-agent/`, etc

Plugins that provide skills: `superpowers/.hermes-plugin`, `gsd-core/.hermes-plugin`, `mattpocock-skills/.hermes-plugin`, `caveman-autostart`

To archive a skill: copy its `SKILL.md` from `~/.hermes/skills/<category>/<skill>/SKILL.md` into `archived/hermes/skills/<skill>/SKILL.md`.

This placeholder avoids duplicating 20+ skills. See live path for full list: `rtk ls ~/.hermes/skills`
