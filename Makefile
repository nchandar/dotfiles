SHELL := /bin/bash

.PHONY: bootstrap bootstrap-omarchy brew link status tmux nvim upgrade update

bootstrap: tmux
	./bootstrap.sh
	$(MAKE) nvim

bootstrap-omarchy:
	./bootstrap-omarchy.sh

brew:
	brew bundle --file ./Brewfile

link:
	./bootstrap.sh --link-only

status:
	@echo "Symlinks in ~/.config:";
	@ls -la ~/.config | egrep "(nushell|tmux|ghostty|hammerspoon|aerospace|nvim|oh-my-posh\.omp\.toml)" || true

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

nvim:
	@NVIM_BIN=""; \
	if command -v nvim >/dev/null 2>&1; then \
		NVIM_BIN="$$(command -v nvim)"; \
	elif [ -x /opt/homebrew/bin/nvim ]; then \
		NVIM_BIN="/opt/homebrew/bin/nvim"; \
	elif [ -x /usr/local/bin/nvim ]; then \
		NVIM_BIN="/usr/local/bin/nvim"; \
	fi; \
	if [ -z "$$NVIM_BIN" ]; then \
		echo "nvim not found; skipping Neovim plugin sync"; \
		exit 0; \
	fi; \
	"$$NVIM_BIN" --headless "+Lazy sync" +qa; \
	"$$NVIM_BIN" --headless "+TSUpdate" +qa

upgrade:
	@if command -v brew >/dev/null 2>&1; then \
		brew update; \
		brew upgrade --greedy-auto-updates; \
		brew bundle --file ./Brewfile; \
	else \
		echo "brew not found; skipping Homebrew updates"; \
	fi

update: upgrade
	@if [ -x ~/.config/tmux/plugins/tpm/bin/update_plugins ]; then \
		TMUX_PLUGIN_MANAGER_PATH=~/.config/tmux/plugins ~/.config/tmux/plugins/tpm/bin/update_plugins all; \
	else \
		echo "TPM not found; run 'make tmux' first"; \
	fi
	$(MAKE) nvim
