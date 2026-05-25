# Claude Preferences

## Environment

- Shell: Nushell, with Oh My Posh (Catppuccin Mocha theme) as the prompt framework
- macOS primary machine; also runs on Linux via Omarchy
- Editor: Neovim

## Communication Style

- Keep responses short and concise
- No emojis unless explicitly requested
- No trailing summaries after completing work — I can read the diff
- When referencing code, include `file:line` so I can navigate directly
- For exploratory questions, give a 2-3 sentence recommendation with the main tradeoff, then wait for me to agree before implementing

## Workflow (dev-* skills)

- When using `/dev-cycle`, always start with the brainstorm/interview stage unless the goal is already fully specific and unambiguous
- **If skipping a dev-cycle stage, say so explicitly and explain why** — do not silently jump ahead
- Confirm the plan before executing — don't implement without approval

## Permissions

- Read-only operations (file reads, grep, git reads, web fetches) require no confirmation — just do them
- Always ask before editing, writing, or running anything destructive

## Memory & Portability

- Persistent preferences live here in CLAUDE.md (tracked in dotfiles), not in auto-memory files
- Auto-memory files are machine-local and path-specific — do not rely on them for preferences
- Skills live in ~/skills repo — run `make install-claude` on a new machine to install them
