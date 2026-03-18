# Neovim

- Config path: `config/nvim/`
- Base: LazyVim (`LazyVim/LazyVim`) with local overrides in `lua/config/` and `lua/plugins/`
- Full details: `config/nvim/README.md`

## Local customizations
- Keymaps are mostly LazyVim defaults, with repo-local Git/DAP bindings including `<leader>gg` and direct DAP function-key controls
- Telescope finder enabled via LazyVim extra `lazyvim.plugins.extras.editor.telescope`
- DAP core enabled via `lazyvim.plugins.extras.dap.core`
- Go development/debugging enabled via `lazyvim.plugins.extras.lang.go`
- Java development/debugging enabled via `lazyvim.plugins.extras.lang.java`
- Diffview plugin retained for Git diff/file-history commands
- LazyGit plugin added for terminal Git UI commands inside Neovim
- Optional Catppuccin colorscheme installed (LazyVim default theme remains default)

## Finder quick commands
- `:Telescope find_files`
- `:Telescope live_grep`
- `:Telescope buffers`
- `:Telescope keymaps`

## Update tooling
`make update` runs `make upgrade`, then:
- `Lazy sync`
- `TSUpdate`

## Diffview quick commands
- `:DiffviewOpen`
- `:DiffviewOpen HEAD~1`
- `:DiffviewFileHistory %`
- `:DiffviewClose`

## LazyGit quick commands
- `<leader>gg`
- `:LazyGit`
- `:LazyGitCurrentFile`
- `:LazyGitFilter`
- `:LazyGitFilterCurrentFile`

## Debugging quick keys
- `<F5>` continue/start
- `<F10>` step over
- `<F11>` step into
- `<F12>` step out
- `<leader>b` toggle breakpoint
- `<leader>B` conditional breakpoint
- `<leader>du` toggle DAP UI
- `<leader>dr` toggle DAP REPL

## Java and Go debugging
- Go uses Delve through `nvim-dap-go`; open a Go buffer in a module and run `<F5>` or `<leader>dc`.
- Java uses `nvim-jdtls` with Mason-managed `java-debug-adapter` and `java-test`; open a Java project and run `<F5>`.
- Java test/debug shortcuts in Java buffers: `<leader>tt`, `<leader>tr`, `<leader>tT`.
