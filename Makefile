SHELL := /bin/bash

.PHONY: bootstrap brew link status

bootstrap:
	./bootstrap.sh

brew:
	brew bundle --file ./Brewfile

link:
	./bootstrap.sh --link-only

status:
	@echo "Symlinks in ~/.config:";
	@ls -la ~/.config | egrep "(nushell|tmux|ghostty|hammerspoon|starship\.toml)" || true
