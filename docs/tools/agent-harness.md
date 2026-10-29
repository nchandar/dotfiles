# Agent harness

Skills and small bash tools that work the same under Claude Code, Codex and OpenCode. It lives in its own repo, `~/agent-harness` (https://github.com/nchandar/agent-harness). Global rules: `config/agents/AGENTS.md`.

## Install
- `make harness` clones the repo if missing, pulls if present, then runs its installer. `bootstrap.sh` clones and installs it too.
- Safe to rerun; it replaces only symlinks.

## Global rules
- One file, `config/agents/AGENTS.md`, linked to `~/.agents/`, `~/.codex/`, `~/.config/opencode/`.
- Claude reads it through `config/claude/CLAUDE.md`, a symlink to it.
- Project `AGENTS.md` files add to it; they do not replace it.

## Skills
| Skill | Use it for |
|---|---|
| `dev-feature` | new behavior or a refactor |
| `dev-debug` | a bug or failing test |
| `dev-research` | a question or a spike, no code changes |
| `dev-review` | a diff |
| `dev-spawn` | handing work to another agent |

Full details are in the agent-harness repo README (`~/agent-harness`).
