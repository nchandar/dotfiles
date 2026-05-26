# Neovim Cheatsheet (LazyVim)

Most-used actions for this repo’s LazyVim setup.

## Modes
- Normal: `Esc`
- Insert: `i`
- Visual: `v`
- Command line: `:`

## Core file actions
- Save: `:w`
- Quit all: `<leader>qq`
- Save and quit: `:wq`
- Force quit: `:q!`

## Finder / navigation (LazyVim defaults, Telescope-backed)
- Find files (root): `<leader><space>` or `:Telescope find_files`
- Live grep (root): `<leader>/` or `:Telescope live_grep`
- Explorer: `<leader>e`
- Buffer switcher: `<leader>,` or `:Telescope buffers`

## Diagnostics and LSP (LazyVim defaults)
- Prev/next diagnostic: `[d` / `]d`
- Code action: `<leader>ca`
- Rename symbol: `<leader>cr`
- Go to definition: `gd`
- References: `gr`
- Hover docs: `K`

## Git
- Open LazyGit: `<leader>gg` or `:LazyGit`
- Open LazyGit for current file: `:LazyGitCurrentFile`
- Open LazyGit with repo filter: `:LazyGitFilter`
- Open LazyGit filtered to current file: `:LazyGitFilterCurrentFile`

## Diffview
- Open diff: `:DiffviewOpen`
- Open commit diff: `:DiffviewOpen HEAD~1`
- Current file history: `:DiffviewFileHistory %`
- Close diff: `:DiffviewClose`

## Markdown authoring
- In-buffer preview toggle: `:Markview Toggle`
- Split preview toggle: `:Markview splitToggle`
- Hybrid edit/preview toggle: `:Markview HybridToggle`
- Browser preview start: `:MarkdownPreview`
- Browser preview toggle: `:MarkdownPreviewToggle`
- Browser preview stop: `:MarkdownPreviewStop`
- Markview health check: `:checkhealth markview`

## Debugging
- Continue/start: `<F5>` or `<leader>dc`
- Step over: `<F10>` or `<leader>dO`
- Step into: `<F11>` or `<leader>di`
- Step out: `<F12>` or `<leader>do`
- Toggle breakpoint: `<leader>b` or `<leader>db`
- Conditional breakpoint: `<leader>B` or `<leader>dB`
- Run with args: `<leader>da`
- Run to cursor: `<leader>dC`
- Toggle DAP UI: `<leader>du`
- Toggle REPL: `<leader>dr`
- Evaluate expression/selection: `<leader>de`

## Go debug notes
- Open a Go buffer in a project with `go.mod` or `go.work`, then use `<F5>` / `<leader>dc`.
- Delve is installed through Mason and used automatically by `nvim-dap-go`.

## Java debug notes
- Open a Java buffer in a Maven/Gradle project to auto-attach `nvim-jdtls`.
- This setup prefers Homebrew `jdtls` when it is installed, which avoids Mason's `java`-on-`PATH` requirement on this machine.
- Mason still installs `java-debug-adapter` and `java-test`, but not `java-language-server`.
- Run current Java test class: `<leader>tt`
- Run nearest Java test: `<leader>tr`
- Pick Java test: `<leader>tT`
- Remote attach config name: `Debug (Attach) - Remote` on `127.0.0.1:5005`

## Useful commands
- Open Lazy UI: `:Lazy`
- Open Mason UI: `:Mason`
- DAP adapter install/uninstall: `:DapInstall`, `:DapUninstall`
- Check health: `:checkhealth`
- Inspect active mappings: `:Telescope keymaps`

## Leader key
- Leader is `Space`.
