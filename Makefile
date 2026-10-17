SHELL := /bin/bash
OS := $(shell uname -s)

.PHONY: bootstrap bootstrap-omarchy bootstrap-omarchy.sh brew herdr link status nvim voxtype upgrade update pull

bootstrap:
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

herdr:
	@./scripts/install-herdr-plugins.sh

link:
	./bootstrap.sh --link-only

status:
	@echo "Symlinks in ~/.config:";
	@ls -la ~/.config | egrep "(ghostty|hammerspoon|aerospace|herdr|nvim|opencode|oh-my-posh\.omp\.toml)" || true
	@ls -la ~/.zshrc 2>/dev/null || true
	@echo "";
	@echo "AI config files:";
	@ls -la ~/.codex/config.toml ~/.claude/settings.json ~/.config/opencode/opencode.jsonc 2>/dev/null || true

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

voxtype:
	@if [ "$(OS)" = "Darwin" ]; then \
		./scripts/install-voxtype.sh; \
	else \
		echo "voxtype: macOS-only target; on Omarchy use the distro package"; \
	fi

upgrade:
	@if command -v brew >/dev/null 2>&1; then \
		brew update; \
		brew upgrade --greedy-auto-updates; \
		brew bundle --file ./Brewfile; \
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
	$(MAKE) nvim
