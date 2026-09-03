#!/usr/bin/env bash
set -euo pipefail

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "$1 is required to install Herdr plugins. Install dependencies, then rerun make herdr." >&2
    exit 1
  fi
}

require_command herdr
require_command go
require_command bun

install_plugin() {
  local source="$1"

  echo "Installing/updating Herdr plugin: $source"
  herdr plugin install "$source" --yes
}

install_plugin kryptamine/herdr-auto-title
install_plugin plannotator/herdr-annotate

echo "Herdr plugins installed. Restart the server to activate changes: herdr server stop"
