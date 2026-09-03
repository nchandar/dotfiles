# Herdr

- Config path: `config/herdr/config.toml`
- Runtime path: `~/.config/herdr/`
- Apply configuration changes: `herdr server reload-config`
- Install OpenCode state and session integration: `herdr integration install opencode`
- Install or refresh Auto Title and the full Annotate plugin: `make herdr`
- Restart the server after installing Auto Title: `herdr server stop`

## Managed plugins

- **Auto Title** names tabs from the active directory, branch, terminal title, and supported agent context. It requires Go.
- **Annotate** captures terminal selections, reviews documents, and sends feedback to the active agent. It requires Bun.

Annotate keybindings use Herdr's default `Ctrl+B` prefix: `A` captures selected text, `Shift+A` copies annotation context, `M` opens the annotation manager, `O` reviews the focused pane's directory, and `Shift+O` reviews the focused agent's latest reply.

The expanded Agent panel uses distinct state glyphs and three rows: agent/state, workspace/tab, and the active terminal title. Press `Ctrl+B`, then `B` to expand a collapsed sidebar; compact and mobile sidebars do not render the expanded rows.

The config file is symlinked into the runtime directory. Logs, sockets, and session state remain local and are not versioned.
