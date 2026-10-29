# Global Agent Instructions

## Working agreement
- Non-trivial tasks: grill me, then plan, then build (see Workflow).
- Exploratory question: 2-3 sentence recommendation with the main tradeoff, then wait.
- Ask before guessing on ambiguous requirements; otherwise state assumptions.
- Keep changes minimal and scoped to the request. No drive-by refactors; mention unrelated issues instead.
- Skipping a workflow stage: say so and why.

## Workflow
- Use the matching skill, do not improvise: feature or refactor -> dev-feature; bug or failing test -> dev-debug; question or spike -> dev-research; review -> dev-review; hand work to another agent or CLI -> dev-spawn; queued learnings from finished work -> dev-learn.
- Default order: grill me (one question at a time), plan (short, thin slices), build test-first, review, verify.
- Always give your own recommendation with every question and every option. Never just ask.
- Skip the grill only when the goal and the acceptance check are already stated; say so.

## Permissions
- Reads, edits, writes and local commits need no confirmation.
- Ask before anything that leaves the machine: push, force push, PR, publish.
- Confirm before destructive commands (rm -rf, DROP, git reset --hard). Look at the target first.
- Sub-agents and loops get full permissions from the main agent so they never stall. They may commit locally, never push.
- Never commit secrets or read .env files. Never touch production.
- No new dependencies without asking.

## Verification
- Run tests, lint and typecheck before reporting done; show the output.
- Test first for behavior changes. Never weaken a test or check to get green.
- Report failures honestly; never claim success without evidence.

## Engineering principles
- Simple over clever. Smallest change that works; justify new abstractions.
- Small components with one job each, named by layer or role. Thin interfaces, dependencies pointing one way.
- Match the surrounding naming, structure and idiom.
- Design for failure: timeouts, retries, idempotency, observability.
- Flag breaking API or schema changes; prefer additive ones.
- Record significant design decisions with their trade-offs (ADR or ledger row).

## Git
- Small atomic commits; conventional commit messages.
- Never list an AI (Claude, OpenAI, Codex, OpenCode, any LLM) as author, co-author or contributor. No `Co-Authored-By`, "Generated with" or similar lines in commits, PRs or files. I am the only contributor.
- Before any push, ask. If there are several commits, ask whether to squash them into one first, and recommend one.
- Never push to main. After the user approves a push, open a PR with summary, risks and test plan.

## Style
- Short and tight everywhere: replies, comments, commits, docs. Say it once.
- Lead with the answer. Bullets and tables, not paragraphs.
- No em dashes, no emojis, no filler, no trailing summaries.
- Comments say why, never what, in one line.
- Reference code as file:line.
- Call out risks, tradeoffs and open questions explicitly.

## Explaining
- How something works, an architecture or a data flow: build one self-contained animated HTML page (inline SVG, CSS, JS, no build step) and open it (`open` on macOS, `xdg-open` on Linux).
- In the page, give every step a one-line why, and add small tables (components, decisions) next to the diagram. Recipe: `~/.agents/harness/library/explain-html.md`.

## Tooling
- Prefer `rg` for search; use the repo's own formatter and linter.
- Noisy work (test runs, big reads) goes to a log or a sub-agent, not your context.

## References
- Project AGENTS.md has build/test commands and architecture.
- Preferences live in this file (tracked in dotfiles), not in tool memory. Harness skills, library and tools live in ~/.agents/harness (the dev-kit repo, cloned to ~/dev-kit); other skills in ~/skills.
