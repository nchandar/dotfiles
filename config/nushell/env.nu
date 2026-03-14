# env.nu
#
# Installed by:
# version = "0.110.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.

# Editor configuration
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"
$env.config.buffer_editor = "nvim"
#
# You can remove these comments if you want or leave
# them for future reference.

# --- Base system paths ---
if ('/opt/homebrew/bin' | path exists) {
  $env.PATH = ($env.PATH | prepend '/opt/homebrew/bin')
}

if ('/usr/local/bin' | path exists) {
  $env.PATH = ($env.PATH | prepend '/usr/local/bin')
}

$env.PATH = (
  $env.PATH
  | prepend '/usr/bin'
  | prepend '/bin'
  | prepend '/usr/sbin'
  | prepend '/sbin'
)

## ${UserConfigDir}/nushell/env.nu
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
if (which carapace | is-not-empty) {
  mkdir $"($nu.cache-dir)"
  carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"
}
