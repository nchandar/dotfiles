#!/usr/bin/env bash
# Ensure XDG_CONFIG_HOME is set for Ghostty-launched Nushell.
export XDG_CONFIG_HOME="$HOME/.config"
exec nu "$@"
