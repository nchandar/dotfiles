SHELL := /bin/bash
OS := $(shell uname -s)

.PHONY: bootstrap bootstrap-omarchy bootstrap-omarchy.sh brew link status tmux nvim upgrade update pull

bootstrap: tmux
	./bootstrap.sh
	$(MAKE) nvim

bootstrap-omarchy:
	@if [ "$$(uname -s)" != "Linux" ]; then \
		echo "bootstrap-omarchy is Linux-only; use 'make bootstrap' on macOS"; \
		exit 1; \
	fi
	./bootstrap-omarchy.sh --install-deps

bootstrap-omarchy.sh: bootstrap-omarchy

brew:
	@brew bundle --file ./Brewfile
	@if ! command -v codex >/dev/null 2>&1; then \
		brew install --cask codex; \
	else \
		echo "codex already installed; skipping"; \
	fi

link:
	./bootstrap.sh --link-only

status:
	@echo "Symlinks in ~/.config:";
	@ls -la ~/.config | egrep "(tmux|ghostty|hammerspoon|aerospace|nvim|opencode|oh-my-posh\.omp\.toml)" || true
	@ls -la ~/.zshrc 2>/dev/null || true
	@echo "";
	@echo "AI config files:";
	@ls -la ~/.codex/config.toml ~/.claude/settings.json ~/.config/opencode/opencode.jsonc 2>/dev/null || true

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
		if ! command -v codex >/dev/null 2>&1; then \
			brew install --cask codex; \
		else \
			echo "codex already installed; skipping"; \
		fi; \
	else \
		echo "brew not found; skipping Homebrew updates"; \
	fi

pull:
	@echo "Pulling dotfiles..."
	git pull
	@if [ -d "$$HOME/skills" ]; then \
		echo "Pulling skills..."; \
		git -C "$$HOME/skills" pull; \
		make -C "$$HOME/skills" install-claude; \
	else \
		echo "skills not found; skipping"; \
	fi

update: pull
	@echo "Upgrading packages..."
	@if [ "$(OS)" = "Darwin" ]; then \
		$(MAKE) upgrade; \
	elif command -v pacman >/dev/null 2>&1; then \
		sudo pacman -Syu --noconfirm; \
	else \
		echo "No supported package manager found; skipping package upgrade"; \
	fi
	@echo "Running bootstrap..."
	@if [ "$(OS)" = "Darwin" ]; then \
		$(MAKE) bootstrap; \
	else \
		./bootstrap-omarchy.sh; \
	fi
	@echo "Updating tmux plugins..."
	@if [ -x ~/.config/tmux/plugins/tpm/bin/update_plugins ]; then \
		TMUX_PLUGIN_MANAGER_PATH=~/.config/tmux/plugins ~/.config/tmux/plugins/tpm/bin/update_plugins all; \
	else \
		echo "TPM not found; skipping tmux plugin update"; \
	fi
	$(MAKE) nvim
