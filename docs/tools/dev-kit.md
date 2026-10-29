# dev-kit

Skills and small bash tools that work the same under Claude Code, Codex and OpenCode. It lives in its own repo, `~/dev-kit` (https://github.com/nchandar/dev-kit). Global rules: `config/agents/AGENTS.md`.

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
| `dev-learn` | turning learnings from finished work into library edits, merged only after you approve |

## State, memory and learning
- Every task keeps an append-only ledger plus a short `state.md` (current picture, pointers only). Durable project notes go to `.devkit/memory.md`.
- All of it is local and git-ignored: `ledger start` adds `.devkit/` to the repo's own `info/exclude`.
- At closeout, general lessons and reusable procedures are queued in a local inbox (`~/.agents/learnings/`). `dev-learn` drafts library changes on a branch and merges only after you approve.
- The library has three tiers: a short principles digest, on-demand deep files, and reusable recipes.

Full details are in the dev-kit repo README (`~/dev-kit`).
