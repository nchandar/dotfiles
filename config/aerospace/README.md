# AeroSpace Keyboard Guide

This setup keeps AeroSpace config in this repo at `config/aerospace/aerospace.toml` and symlinks it to `~/.config/aerospace`.

## Modifier keys
- `alt` = Option
- `shift` = Shift
- `cmd` = Command
- `ctrl` = Control

## Core movement
- `alt-h/j/k/l`: focus left/down/up/right window
- `alt-shift-h/j/k/l`: move focused window left/down/up/right

## Layout controls
- `alt-/`: cycle tiling layout orientation
- `alt-,`: cycle accordion layout orientation
- `alt--`: shrink focused window/container
- `alt-=`: grow focused window/container

## Workspaces
- `alt-1..9` and `alt-a..z` (selected letters): switch workspace
- `alt-shift-1..9` and `alt-shift-a..z`: move focused window to workspace
- `alt-tab`: switch to previous workspace
- `alt-shift-tab`: move current workspace to next monitor

## Service mode (maintenance mode)
- `alt-shift-;`: enter service mode
- In service mode:
  - `esc`: reload config and return to main mode
  - `r`: flatten workspace tree (layout reset)
  - `f`: toggle floating/tiling for focused window
  - `backspace`: close all windows except focused one
  - `alt-shift-h/j/k/l`: join with neighbor container

## Startup
- `start-at-login = true` is enabled in this repo config.

## Coexistence with Hammerspoon
- Hammerspoon remains enabled. If shortcuts conflict, whichever app receives the shortcut first will act.
- If you want a clean AeroSpace-only keyboard setup later, we can migrate and remove overlapping Hammerspoon bindings.
