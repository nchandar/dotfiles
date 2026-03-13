<div class="hero">
  <h1>Dotfiles Control Center</h1>
  <p>Fast lookup for setup steps, shortcuts, and tool-specific behavior across this repo.</p>
</div>

<div class="section-title">All Tools + Keybindings</div>
<div class="link-grid">
  <a class="link-card" href="keyboard-shortcuts/">
    <strong>Keyboard Shortcuts</strong>
    <span>Single-page quick reference across all configured tools.</span>
  </a>
  <a class="link-card" href="keybindings/aerospace/">
    <strong>AeroSpace</strong>
    <span>Tiling and workspace keybindings.</span>
  </a>
  <a class="link-card" href="keybindings/hammerspoon/">
    <strong>Hammerspoon</strong>
    <span>Window layout and automation hotkeys.</span>
  </a>
  <a class="link-card" href="keybindings/tmux/">
    <strong>tmux</strong>
    <span>Prefix, splits, resize, and pane workflow keys.</span>
  </a>
  <a class="link-card" href="tools/nvim/">
    <strong>Neovim</strong>
    <span>Editor setup and keybinding references.</span>
  </a>
  <a class="link-card" href="tools/nushell/">
    <strong>Nushell</strong>
    <span>Shell config location and behavior notes.</span>
  </a>
  <a class="link-card" href="tools/yazi/">
    <strong>Yazi</strong>
    <span>Terminal file manager install path, config location, and launch workflow.</span>
  </a>
  <a class="link-card" href="tools/ghostty/">
    <strong>Ghostty</strong>
    <span>Terminal configuration and portability notes.</span>
  </a>
  <a class="link-card" href="tools/oh-my-posh/">
    <strong>Oh My Posh</strong>
    <span>Prompt configuration path, theme, and Nushell usage.</span>
  </a>
  <a class="link-card" href="troubleshooting/">
    <strong>Troubleshooting</strong>
    <span>Common recovery steps for setup and runtime issues.</span>
  </a>
</div>

<div class="section-title">Where To Start</div>
<div class="link-grid">
  <a class="link-card" href="setup/bootstrap/">
    <strong>1) Start Here: Bootstrap</strong>
    <span>Run the full setup on a new machine.</span>
  </a>
  <a class="link-card" href="setup/symlinks/">
    <strong>2) Verify Symlinks</strong>
    <span>Confirm configs are linked into <code>~/.config</code>.</span>
  </a>
  <a class="link-card" href="keyboard-shortcuts/">
    <strong>3) Learn Daily Shortcuts</strong>
    <span>Quick keyboard workflow across tmux, nvim, and AeroSpace.</span>
  </a>
  <a class="link-card" href="setup/bootstrap/">
    <strong>4) Update Existing Machine</strong>
    <span>Use <code>make upgrade</code> for Homebrew apps like Ghostty, or <code>make update</code> for the full refresh.</span>
  </a>
</div>

## Source of truth
- Repo: `~/dotfiles`
- Configs: `~/dotfiles/config/*`
- Active paths: symlinked into `~/.config/*`
