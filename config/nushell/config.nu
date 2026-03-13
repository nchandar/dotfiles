# config.nu
#
# Installed by:
# version = "0.110.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

let omp_config = ($nu.home-dir | path join ".config" "oh-my-posh.omp.toml")
let legacy_starship_autoload = ($nu.data-dir | path join "vendor" "autoload" "starship.nu")

if ($legacy_starship_autoload | path exists) {
  rm -f $legacy_starship_autoload
}

if ((which oh-my-posh | is-not-empty) and ($omp_config | path exists)) {
  oh-my-posh init nu --config $omp_config
}

# Launch Yazi and adopt its last working directory on exit.
def --env y [...args] {
  let tmp = (mktemp -t "yazi-cwd.XXXXXX" | str trim)
  ^yazi ...$args --cwd-file $tmp

  let cwd = (open --raw $tmp | str trim)
  if $cwd != "" and $cwd != $env.PWD and ($cwd | path exists) {
    cd $cwd
  }

  rm -f $tmp
}

# --- Carapace external completions ---

let carapace_completer = {|spans|
  if ($spans | is-empty) { return null }
  carapace $spans.0 nushell ...$spans | from json
}

$env.config.show_banner = false

$env.config = (
  $env.config
  | upsert completions.external {
      enable: true
      max_results: 100
      completer: $carapace_completer
    }
)
