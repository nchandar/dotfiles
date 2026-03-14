#!/usr/bin/env bash
# Ensure XDG_CONFIG_HOME is set for Ghostty-launched tmux.
export XDG_CONFIG_HOME="$HOME/.config"
exec tmux new-session -A -s main
