# Agent harness

Skills and small bash tools that work the same under Claude Code, Codex and OpenCode. Source: `agents/harness/`. Global rules: `config/agents/AGENTS.md`.

## Install
- `make harness` (also run by `bootstrap.sh`). Safe to rerun; it replaces only symlinks.
- Links `agents/harness` to `~/.agents/harness`, and the `dev-*` skills into `~/.claude/skills`, `~/.codex/skills` and `~/.agents/skills`.
- Check the CLIs: `~/.agents/harness/bin/spawn --doctor`.
- OpenCode v2 needs its background service once: `opencode service start`.

## Global rules
- One file, `config/agents/AGENTS.md`, linked to `~/.agents/`, `~/.codex/`, `~/.config/opencode/`.
- Claude reads it through `config/claude/CLAUDE.md`, a symlink to it.
- Project `AGENTS.md` files add to it; they do not replace it.

## Skills
| Skill | Use it for | Route |
|---|---|---|
| `dev-feature` | new behavior or a refactor | grill, spec, slices, test-first, review, verify, ship |
| `dev-debug` | a bug or failing test | repro, root cause, doubt, regression test, fix |
| `dev-research` | a question or spike | sources, evidence, report (.md or .html), no code changes |
| `dev-review` | a diff | Standards and Spec scouts in parallel, blast radius |
| `dev-spawn` | handing work to another agent | brief, scout or ship, worktrees, cap 2, depth 1 |

Each skill opens with a checklist the agent copies into its task list. Steps read small files from `library/` on demand (tdd, debug-method, verify, doubt and 12 more), so the always-loaded cost stays near 3 KB.

## Tools
| Tool | What it does |
|---|---|
| `bin/ledger` | per-task, append-only TSV log (`start`, `done`, rows, `path`, `base`) |
| `bin/reconcile` | open tasks, resume point and worker states, rebuilt from disk and git |
| `bin/spawn` | run a headless worker on claude, codex or opencode; brief in, handoff out |
| `bin/run` | run a command; full output to a log, short summary back |
| `bin/lint-budget` | enforce size caps, `dev-` names, resolvable references |

## Cross-agent use
- Any CLI can be the main agent and any CLI the worker: "open a codex instance and run X" becomes `bin/spawn --prompt "X" <id> codex`.
- Workers are headless one-shots with permissions skipped, so they never stall. They can commit locally and can never push (a dead push URL is set on every remote).
- `HARNESS_SAFE=1` restores restricted modes. `HARNESS_MODEL` or `--model` picks a cheaper model. `HARNESS_TIMEOUT` (900 s) kills a hung worker.
- Cap of 2 live workers per repo, shared by all sessions.

## Herdr view
- On by default when the herdr server is reachable: each worker gets a tab labelled `<id> · <cli> · <shape>` in the current workspace. The tab tails the worker log, and the worker shows in the Agents panel (`working`, then `idle` or `blocked`) with a title and display name.
- Success closes the tab. Failure, timeout or a scout that changed files keeps it open as `blocked` and raises a notification. `bin/spawn --close-views` closes the kept tabs.
- Workers still run headless with the same guards; the tab only watches. Without herdr, spawn runs exactly as before.
- Switches: `HARNESS_VIEW=off` disables it, `HARNESS_VIEW_KEEP=1` keeps tabs after success, `HARNESS_VIEW_NOTIFY=all` also notifies on success, `HARNESS_VIEW_CLOSE_DELAY` (2 s) sets how long a finished tab stays.

## State on disk
```
<repo>/.harness/               gitignored
  run/slot.N                   worker slots (repo-wide cap)
  tasks/<slug>-<date>-<rand>/  one per session or job, so parallel sessions never collide
    ledger.tsv  briefs/  handoffs/  run/  runs/  wt/
```
New terminal: `bin/reconcile`, then resume a task (its `next` row) or `bin/ledger start <slug>`.

## Tests and evals
- `agents/harness/tests/run-all.sh` runs every script suite with a fake CLI and no tokens.
- `agents/harness/evals/e2e.sh <claude|codex>` runs the real cross-agent scenario with that CLI as the main agent.

## Measured
- Always loaded: about 3 KB (global `AGENTS.md` 3.2 KB, five skill descriptions 0.6 KB). A route adds one skill (2 to 3 KB) plus the library files it names.
- Cross-agent run, main plus two parallel workers, with herdr tabs on: Claude main with codex and opencode workers, 117 s, about 0.7 GB; Codex main with claude and opencode workers, 96 s, about 0.7 GB. Both 7/7 on `evals/e2e.sh`.

## Limits
- OpenCode cannot start its service from a sandboxed shell; start it once from a normal terminal.
- `--resume` for workers is not built; start a new worker with the earlier handoff as context.
- The older `dev-*` skills in `~/skills` stay installed until you remove their links; they still count toward the always-listed descriptions.
