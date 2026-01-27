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
	@ls -la ~/.config | egrep "(nushell|tmux|ghostty|hammerspoon|starship\.toml)" || true

tmux:
	@mkdir -p ~/.tmux/plugins
	@if [ ! -d ~/.tmux/plugins/tpm ]; then \
		echo "Installing TPM..."; \
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; \
	fi
	@if [ ! -e ~/.tmux.conf ]; then \
		echo "source-file ~/.config/tmux/tmux.conf" > ~/.tmux.conf; \
		echo "Created ~/.tmux.conf -> ~/.config/tmux/tmux.conf"; \
	fi
	@if [ -x ~/.tmux/plugins/tpm/bin/install_plugins ]; then \
		TMUX_PLUGIN_MANAGER_PATH=~/.tmux/plugins ~/.tmux/plugins/tpm/bin/install_plugins; \
	fi
