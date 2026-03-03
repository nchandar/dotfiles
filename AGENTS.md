# AGENTS.md

Guidance for agents working in `/Users/niranjan/dotfiles`.

## Primary goal
Keep config and docs in sync. If behavior changes in `config/`, update the related docs in the same change.

## Source-of-truth map
- Runtime config: `config/*`
- Top-level overview: `README.md`
- Docs site pages: `docs/*`
- Neovim details: `config/nvim/README.md`, `config/nvim/CHEATSHEET.md`, `docs/tools/nvim.md`, `docs/keyboard-shortcuts.md`

## Required doc updates for Neovim changes
When changing Neovim plugins, keymaps, LSP, or workflows:
1. Update `config/nvim/README.md` (feature and workflow notes).
2. Update `config/nvim/CHEATSHEET.md` (user-facing commands/keymaps).
3. Update `docs/tools/nvim.md` (docs site summary).
4. Update `docs/keyboard-shortcuts.md` if any binding/command quick reference changed.

Example: adding a plugin like `diffview.nvim` requires plugin mention + user commands where applicable.

## Consistency checks
- Ensure keybindings in docs match `config/nvim/lua/config/keymaps.lua`.
- Ensure plugin claims match `config/nvim/lua/plugins.lua` and `config/nvim/lua/plugins/*.lua`.
- Prefer documenting exact command names (for example `:DiffviewOpen`), not vague descriptions.

## Validation commands
Run from repo root:
```sh
rg -n "Diffview|leader>r|Ctrl-r|Neovim" docs config/nvim README.md
```

For docs preview when needed:
```sh
python3 -m mkdocs serve
```
