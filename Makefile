SHELL := /bin/bash

.PHONY: bootstrap brew link status tmux

bootstrap: tmux
	./bootstrap.sh

brew:
	brew bundle --file ./Brewfile

link:
	./bootstrap.sh --link-only

status:
	@echo "Symlinks in ~/.config:";
	@ls -la ~/.config | egrep "(nushell|tmux|ghostty|hammerspoon|nvim|starship\.toml)" || true

tmux:
	@mkdir -p ~/.config/tmux/plugins
	@if [ ! -d ~/.config/tmux/plugins/tpm ]; then \
		echo "Installing TPM..."; \
		git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm; \
	fi
	@if [ ! -e ~/.tmux.conf ]; then \
		echo "source-file ~/.config/tmux/tmux.conf" > ~/.tmux.conf; \
		echo "Created ~/.tmux.conf -> ~/.config/tmux/tmux.conf"; \
	fi
	@if command -v tmux >/dev/null 2>&1; then \
		tmux start-server \; set-environment -g TMUX_PLUGIN_MANAGER_PATH "$$HOME/.config/tmux/plugins" >/dev/null 2>&1 || true; \
	fi
	@if [ -x ~/.config/tmux/plugins/tpm/bin/install_plugins ]; then \
		TMUX_PLUGIN_MANAGER_PATH=~/.config/tmux/plugins ~/.config/tmux/plugins/tpm/bin/install_plugins; \
	fi
