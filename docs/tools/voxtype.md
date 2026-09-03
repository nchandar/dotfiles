# Voxtype

Push-to-talk voice-to-text. Hold **FN** (Globe key), speak, release — the
transcription is typed at the cursor.

- Install path: `/Applications/Voxtype.app` (installed from the GitHub release
  DMG by `scripts/install-voxtype.sh`, **not** Homebrew)
- CLI: `/opt/homebrew/bin/voxtype` symlinked to the app's bundled binary
- Config path: `config/voxtype/config.toml`
- Symlink target: `~/Library/Application Support/voxtype/config.toml`
- Model: `base.en` Whisper, downloaded to
  `~/Library/Application Support/voxtype/models/`
- Logs: `~/Library/Logs/voxtype/`

## Why not Homebrew

The `peteonrails/voxtype` cask is pinned to 0.7.5 and built for the old
bare-binary layout. Voxtype 1.0.1+ ships a `Voxtype.app` bundle, which the cask
cannot install (`brew upgrade` fails with a missing-symlink error). Until the
tap adopts the app-bundle layout, `scripts/install-voxtype.sh` installs
straight from the release DMG:

```sh
make voxtype              # latest release, idempotent
./scripts/install-voxtype.sh --version 1.0.1
./scripts/install-voxtype.sh --force     # reinstall current version
```

`bootstrap.sh` runs it automatically on macOS (so `make bootstrap` and
`make update` keep it current).

## Permissions

The script cannot grant macOS TCC permissions. Grant these once in
**System Settings > Privacy & Security**:

- **Accessibility** — enable Voxtype (types text, reads the hotkey)
- **Input Monitoring** — enable Voxtype
- **Microphone** — enable Voxtype (prompts on first FN press)

After an app move or reinstall the old permission entry goes stale and the
toggle does nothing. Reset and re-grant:

```sh
tccutil reset Accessibility io.voxtype.daemon
tccutil reset ListenEvent io.voxtype.daemon
tccutil reset Microphone io.voxtype.daemon
pkill -f "Voxtype.app/Contents/MacOS/voxtype-bin"; open /Applications/Voxtype.app
```

The `setup-voxtype` Claude Code skill automates this whole flow.

## Checking status

```sh
voxtype status                        # idle / recording / transcribing
voxtype setup app-bundle --status     # install, login item, running PIDs
tail -f ~/Library/Logs/voxtype/stdout.log
```

A healthy startup logs `Model loaded, ready for voice input` and `Listening for
hotkey: FN` with no `Accessibility permission not granted` line.
