# Neovim (LazyVim)

This repo now uses a **LazyVim-based** setup in `config/nvim/`.

## What’s included
- Base distribution: `LazyVim/LazyVim`.
- Plugin manager: `lazy.nvim`.
- Keymaps: LazyVim defaults plus repo-local Git/DAP bindings, including `<leader>gg` for `:LazyGit` and direct DAP function-key controls.
- Default finder: Telescope via LazyVim extra `lazyvim.plugins.extras.editor.telescope`.
- LSP servers enabled via `nvim-lspconfig` / language extras: `lua_ls`, `html`, `cssls`, `jsonls`, `ts_ls`, `gopls`, `jdtls`.
- Formatting/linting via LazyVim-native stack:
  - `conform.nvim`: `stylua`, `prettier`, `shfmt`, `black`, `goimports` + `gofmt`, `rustfmt`
  - `nvim-lint`: `eslint_d`, `shellcheck`, `ruff`
- Debugging via LazyVim extras:
  - Core DAP UI/virtual text from `lazyvim.plugins.extras.dap.core`
  - Go debugging via `nvim-dap-go` + `delve`
  - Java debugging/testing via `nvim-jdtls` + `java-debug-adapter` + `java-test`
- Git workflows: `diffview.nvim` commands for diffs/history and `lazygit.nvim` for terminal Git UI.
- Markdown workflows: `markview.nvim` for in-buffer preview rendering and `markdown-preview.nvim` for browser preview.
- Theme setup: LazyVim default colorscheme remains default; `catppuccin` is installed as an optional alternative.

## Install
1. Ensure dependencies are installed (`brew bundle` or `make bootstrap`).
2. Link configs (`make link` or `make bootstrap`).
3. `make bootstrap` now runs a headless Neovim plugin sync automatically.
4. Open Neovim and run `:Lazy sync` only if you need to resync manually.

`lazygit` is installed through the repo `Brewfile` and is required for `:LazyGit`.

`mason.nvim` installs the debug adapters used here (`delve`, `java-debug-adapter`, `java-test`) after plugin sync.

`markdown-preview.nvim` needs `node`, which is already installed through the repo `Brewfile`.

`nvim-treesitter` now ensures the Markdown preview parsers used here are installed: `markdown`, `markdown_inline`, `html`, and `yaml`.

## Update (headless)
```sh
nvim --headless "+Lazy sync" +qa
nvim --headless "+TSUpdate" +qa
```
These are also run by `make update` from repo root.

## Diffview commands
- `:DiffviewOpen`
- `:DiffviewOpen HEAD~1`
- `:DiffviewFileHistory %`
- `:DiffviewClose`

## LazyGit commands
- `:LazyGit`
- `:LazyGitCurrentFile`
- `:LazyGitFilter`
- `:LazyGitFilterCurrentFile`

## Markview commands
- `:Markview Toggle`
- `:Markview splitToggle`
- `:Markview HybridToggle`
- `:checkhealth markview`

## MarkdownPreview commands
- `:MarkdownPreview`
- `:MarkdownPreviewToggle`
- `:MarkdownPreviewStop`

## Git keymaps
- `<leader>gg`: open `LazyGit`

## Telescope commands
- `:Telescope find_files`
- `:Telescope live_grep`
- `:Telescope buffers`
- `:Telescope keymaps`

## Debugging keymaps
- `<F5>`: start/continue the active debug configuration
- `<F10>`: step over
- `<F11>`: step into
- `<F12>`: step out
- `<leader>b`: toggle breakpoint
- `<leader>B`: set conditional breakpoint
- `<leader>db`: toggle breakpoint (LazyVim DAP default)
- `<leader>dc`: continue
- `<leader>du`: toggle DAP UI
- `<leader>dr`: toggle DAP REPL

## Go debugging
- Open a Go file inside a module (`go.mod` / `go.work`) and press `<F5>` or use LazyVim DAP mappings like `<leader>dc`.
- `nvim-dap-go` provides Delve-backed launch configurations for normal runs, tests, and attach flows.

## Java debugging
- Open a Java project (`pom.xml`, `build.gradle`, etc.) and `nvim-jdtls` will attach automatically.
- `<F5>` starts or resumes the selected Java debug configuration.
- `<leader>tt`: run the current Java test class through the debugger
- `<leader>tr`: run the nearest Java test through the debugger
- `<leader>tT`: pick a Java test to run
- Remote attach is available through the built-in `Debug (Attach) - Remote` Java DAP configuration on port `5005`.

## Files
- `config/nvim/init.lua`
- `config/nvim/lazyvim.json`
- `config/nvim/lua/config/lazy.lua`
- `config/nvim/lua/config/options.lua`
- `config/nvim/lua/config/keymaps.lua`
- `config/nvim/lua/plugins/lsp.lua`
- `config/nvim/lua/plugins/formatting.lua`
- `config/nvim/lua/plugins/diffview.lua`
- `config/nvim/lua/plugins/debugging.lua`
- `config/nvim/lua/plugins/lazygit.lua`
- `config/nvim/lua/plugins/markdown.lua`
- `config/nvim/lua/plugins/tmux-navigator.lua`
- `config/nvim/lua/plugins/catppuccin.lua`

## Notes
- Conflict policy is to keep LazyVim defaults where overlaps exist, with a single repo-local LazyGit launcher on `<leader>gg`.
- Leader-based motions/actions follow LazyVim defaults.
- Finder mappings like `<leader><space>`, `<leader>/`, and `<leader>,` now open Telescope pickers.
- Debugging support is repo-local in `lua/plugins/debugging.lua`, with LazyVim extras providing the Java/Go adapters and default `<leader>d...` actions.
- `markview.nvim` is loaded at startup per upstream guidance so its preview rendering is ready when opening Markdown buffers.
