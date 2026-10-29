# dotfiles

Portable terminal + tooling setup (macOS + Omarchy Linux workflows).

## What's in here
- `config/zsh/.zshrc` zsh config, **macOS only** (OMP prompt, carapace completions, yazi `y` helper)
- `config/ghostty/` Ghostty config (including themes)
- `config/herdr/` Herdr terminal workspace-manager config
- `config/hammerspoon/` Hammerspoon config (`init.lua`)
- `config/aerospace/` AeroSpace config (`aerospace.toml`, `README.md`)
- `config/nvim/` Neovim config (LazyVim base + local overrides, Diffview + LazyGit git workflows, Markdown previews, Java/Go DAP)
- `config/yazi/` Yazi config (`yazi.toml`)
- `config/opencode/` global OpenCode config (`opencode.jsonc`) with Superpowers + Browser MCP
- `config/codex/` shared Codex config template (`config.toml`) without machine-specific trust state
- `config/claude/` global Claude Code settings (`settings.json`)
- `config/agents/` one global `AGENTS.md` for every agent, linked into Claude (`CLAUDE.md`), Codex, OpenCode and `~/.agents`
- dev-kit (skills, library, `bin/` tools) lives in its own repo, cloned to `~/dev-kit` by bootstrap (see `docs/tools/dev-kit.md`)
- `.mcp.json` project-shared Claude Code MCP servers for this repo
- `config/oh-my-posh.omp.toml` Oh My Posh prompt config (single-line rounded Catppuccin pills; path/prompt on the left, git/status/time/battery on the right)
- `Brewfile` Homebrew packages used for this setup, including Git, GitHub CLI, Bun, Ghostty, VS Code, Claude Code, Codex, and OpenCode
- `scripts/install-herdr-plugins.sh` portable installer for the versioned Herdr plugin set

## Layout
- `config/` versioned configs that are symlinked into `~/.config`
- `local/` machine-specific overrides or notes (ignored by git)

## Shells
Shell config is per-platform and only one side is managed here:

- **macOS: zsh.** `config/zsh/.zshrc` is symlinked to `~/.zshrc` by `bootstrap.sh`. This is the file to edit for prompt, completions, and shell helpers.
- **Omarchy/Linux: bash, unmanaged.** Omarchy ships bash as the default shell and owns its own config: `~/.bashrc` sources `~/.local/share/omarchy/default/bash/rc`, which pulls in Omarchy's aliases, envs, functions, completions, and inputrc. These dotfiles deliberately do not link a shell config on Linux — leave bash alone and let Omarchy manage it. Machine-local additions (PATH entries, cargo env, etc.) go directly in `~/.bashrc`.

Nothing needs to be kept in sync between the two. `config/zsh/.zshrc` is not used on Omarchy.

## Bootstrap
```sh
bash ~/dotfiles/bootstrap.sh
```

Omarchy/Linux bootstrap:

```sh
bash ~/dotfiles/bootstrap-omarchy.sh
```

Link-only mode:

```sh
bash ~/dotfiles/bootstrap-omarchy.sh --link-only
```
Or with Make:
```sh
cd ~/dotfiles
make bootstrap           # macOS
make bootstrap-omarchy   # Omarchy/Linux (install deps + link + nvim)
```

`make bootstrap-omarchy` is Linux-only and exits with guidance on macOS.

## Setup on a new Mac (recommended)
```sh
git clone git@github.com:nchandar/dotfiles.git ~/dotfiles
bash ~/dotfiles/bootstrap.sh
```

## New machine checklist (quick)
```sh
git clone git@github.com:nchandar/dotfiles.git ~/dotfiles
cd ~/dotfiles
make bootstrap
```

## Setup on a new Mac (manual)
1) Install Homebrew (if needed)
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2) Install packages
```sh
brew bundle --file ~/dotfiles/Brewfile
```

This installs the repo's macOS toolchain, including `git`, `gh`, `bun`, `ghostty`, `visual-studio-code`, `claude-code`, `codex`, and `opencode`.

3) Symlink configs into `~/.config`
```sh
mkdir -p ~/.config
ln -s ~/dotfiles/config/zsh/.zshrc ~/.zshrc
ln -s ~/dotfiles/config/ghostty ~/.config/ghostty
mkdir -p ~/.config/herdr
ln -s ~/dotfiles/config/herdr/config.toml ~/.config/herdr/config.toml
ln -s ~/dotfiles/config/hammerspoon ~/.config/hammerspoon
ln -s ~/dotfiles/config/aerospace ~/.config/aerospace
ln -s ~/dotfiles/config/nvim ~/.config/nvim
ln -s ~/dotfiles/config/yazi ~/.config/yazi
ln -s ~/dotfiles/config/oh-my-posh.omp.toml ~/.config/oh-my-posh.omp.toml
ln -s ~/dotfiles/config/opencode/opencode.jsonc ~/.config/opencode/opencode.jsonc
cp ~/dotfiles/config/codex/config.toml ~/.codex/config.toml
ln -s ~/dotfiles/config/claude/settings.json ~/.claude/settings.json
```

Claude Code also reads this repo's committed `.mcp.json` when you run `claude` from `~/dotfiles`.
Codex uses a copied starter config instead of a symlink because it stores personal trust and marketplace state in `~/.codex/config.toml`.

4) AeroSpace startup and keybindings
- Startup is enabled via `start-at-login = true` in `config/aerospace/aerospace.toml`.
- Keybinding guide: `config/aerospace/README.md`.

## Setup on Omarchy/Linux

Omarchy keeps its own bash setup; these dotfiles do not touch the shell here. See [Shells](#shells).

1) Install dependencies using your package manager flow
   - Required: `neovim`, `ghostty`, `oh-my-posh`, `lazygit`, `carapace`, `code`, `node`, `bun`, `go`, `rust`, `yazi`, `opencode`, `openai-codex`, `herdr`

   Example (Pacman/Omarchy style):

   ```sh
   sudo pacman -S neovim ghostty oh-my-posh lazygit carapace code nodejs bun go rust yazi opencode openai-codex herdr
   ```

   If `oh-my-posh` or `carapace` are unavailable in your pacman repos, install `oh-my-posh-bin` and/or `carapace-bin` via your AUR/helper.
   Claude Code does not currently ship as an official Arch package here, so install it separately with Anthropic's installer when you need the CLI.

2) Use the dedicated bootstrap
```sh
cd ~/dotfiles
bash bootstrap-omarchy.sh --install-deps
```

3) Manual equivalent flow
```sh
mkdir -p ~/.config
# no shell config here: Omarchy owns ~/.bashrc
ln -s ~/dotfiles/config/ghostty ~/.config/ghostty
mkdir -p ~/.config/herdr
ln -s ~/dotfiles/config/herdr/config.toml ~/.config/herdr/config.toml
ln -s ~/dotfiles/config/nvim ~/.config/nvim
ln -s ~/dotfiles/config/oh-my-posh.omp.toml ~/.config/oh-my-posh.omp.toml
ln -s ~/dotfiles/config/opencode/opencode.jsonc ~/.config/opencode/opencode.jsonc
cp ~/dotfiles/config/codex/config.toml ~/.codex/config.toml
ln -s ~/dotfiles/config/claude/settings.json ~/.claude/settings.json
```

## Make targets
- `make bootstrap` run full bootstrap (brew + links + Neovim plugin sync)
- `make brew` run only Homebrew bundle
- `make herdr` install or update the managed Herdr plugins
- `make harness` link the dev-kit skills and tools for Claude, Codex and OpenCode
- `make link` create symlinks only
- `make status` show current symlinks
- `make bootstrap-omarchy` run Omarchy/Linux bootstrap flow with dependency install (`./bootstrap-omarchy.sh --install-deps`)
- `make nvim` run headless `Lazy sync` and `TSUpdate`
- `make upgrade` update Homebrew packages/casks, including auto-updating casks like Ghostty, VS Code, Claude Code, and Codex
- `make update` refresh packages, rerun bootstrap (including Herdr plugins), then update Neovim plugins/tooling
- `bootstrap-omarchy.sh` supports Omarchy/Linux flags: `--install-deps` and `--link-only`, keeping macOS `bootstrap.sh` unchanged

## Docs site
- Source lives in `docs/` with config in `mkdocs.yml`.
- GitHub Pages deploy is automated by `.github/workflows/docs-pages.yml`.
- Local preview:
```sh
python3 -m pip install -r requirements-docs.txt
python3 -m mkdocs serve
```

## Options and settings
- **Symlinks vs copy**: This setup uses symlinks so the repo is the single source of truth. If you prefer copies, do so manually but keep them in sync.
- **Carapace completions**: `carapace` is installed via Brewfile and used for external completions in zsh.
- **Yazi**: Installed via Brewfile. Use `y` from zsh so exiting Yazi can update the current shell directory.
- **OpenCode**: Global config is versioned at `config/opencode/opencode.jsonc`, including Superpowers and a Playwright Browser MCP server. Restart OpenCode after config changes.
- **Herdr**: Configuration is versioned at `config/herdr/config.toml` and symlinked to `~/.config/herdr/config.toml`; runtime state remains local in `~/.config/herdr`. Bootstrap and `make update` install or refresh Auto Title and the full Annotate plugin from their upstream default branches; run `make herdr` to do this directly. Auto Title requires a server restart after installation (`herdr server stop`). Install the OpenCode integration after Herdr is available with `herdr integration install opencode`.
- **Codex**: Shared defaults live at `config/codex/config.toml`, but bootstrap copies them only when `~/.codex/config.toml` is missing. Codex writes personal trust and marketplace state into that local file, so it is intentionally not symlinked.
- **Claude Code**: Global user settings are versioned at `config/claude/settings.json`, and this repo commits `.mcp.json` for Claude Code's project-scoped MCP servers.
- **Superpowers**: OpenCode is configured declaratively in `opencode.jsonc`. Claude Code and Codex still use their plugin marketplaces for one-time install/activation.
- **Marketplace installs (Claude Code)**: Run `/plugin install superpowers@claude-plugins-official` once after installing `claude-code`.
- **Marketplace installs (Codex)**: Open `/plugins` and install `superpowers` from the official Codex plugin marketplace.
- **Neovim**: See `config/nvim/README.md` for LazyVim setup, plugins, keymaps, Git workflows, Markdown preview workflows, and tooling details.
- **AeroSpace + Hammerspoon**: Both are enabled. If shortcuts overlap, whichever app captures the shortcut first will act.
- **Local overrides**: Put per-machine notes or overrides in `local/` (ignored).

## Git ignored items
- `local/`
- generated/runtime files
