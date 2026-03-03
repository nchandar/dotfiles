# Troubleshooting

## AeroSpace CLI says server not running
Launch `AeroSpace.app` once and grant macOS accessibility permissions.

## Symlink not updating
If a destination already exists, bootstrap skips it by design. Move or remove the existing file, then rerun:
```sh
make link
```

## tmux plugin issues
Reinstall plugins:
```sh
make tmux
```

## Brewfile mismatch
Check and reconcile:
```sh
brew bundle check --file ./Brewfile
brew bundle install --file ./Brewfile
```
