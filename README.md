# RAID Whatever It Took (Linux)

Battle-tested Linux setup for running **RAID: Shadow Legends** when the normal launcher flow is unstable or account-bound.

This repo captures the exact workaround stack that worked:
- Steam install path for game payload (`app id 2333480`)
- Standalone **Plarium Play** launcher running through **Proton Experimental**
- Reusable desktop shortcuts and scripts for quick bootstrap on a new machine

## Why this exists

In our testing, the Steam launch path can tie login behavior to Steam account context. The reliable path for Plarium account login was:
1. Keep Steam/Proton installed
2. Create a dedicated Proton prefix for Plarium Play
3. Run Plarium Play installer + launcher directly under Proton
4. Launch RAID from Plarium Play

## Requirements

- Linux desktop
- Steam installed and launched once
- `Proton - Experimental` installed inside Steam
- `wmctrl` optional (for window checks)

## Quick Start

1. Put `PlariumPlayInstaller.exe` in `~/Downloads/`.
2. From repo root:

```bash
./scripts/install-plarium-proton.sh
./scripts/launch-plarium-proton.sh
```

3. Optional desktop shortcuts:

```bash
./scripts/create-desktop-shortcuts.sh
```

## One-Shot Bootstrap

Run the full known-good flow:

```bash
./scripts/bootstrap-raid-proton.sh
```

Useful flags:

```bash
./scripts/bootstrap-raid-proton.sh --launch
./scripts/bootstrap-raid-proton.sh --skip-install --launch
./scripts/bootstrap-raid-proton.sh --installer "/path/to/PlariumPlayInstaller.exe"
```

## After RAID Updates

RAID updates can overwrite WebView arguments and break `Tournaments` / `Events`.

Reapply the fix with:

```bash
./scripts/reapply-raid-webview-fix.sh
```

You can also pass the args file directly:

```bash
./scripts/reapply-raid-webview-fix.sh "/path/to/WebViewCommandLineArgs.txt"
```

## What gets created

- Proton prefix: `~/.local/share/proton-prefixes/plarium-play`
- Plarium exe path in prefix:
  - `~/.local/share/proton-prefixes/plarium-play/pfx/drive_c/users/steamuser/AppData/Local/PlariumPlay/PlariumPlay.exe`

## Included launch modes

- `desktop/Install-Raid-Steam.desktop`: Steam install prompt (`steam://install/2333480`)
- `desktop/Play-Raid-Steam.desktop`: direct Steam launch (`steam://rungameid/2333480`)
- `desktop/Install-Plarium-Proton.desktop.template`: standalone installer via Proton
- `desktop/Plarium-Proton.desktop.template`: standalone Plarium launcher via Proton

## Observed behavior notes

- First login can sit on "loading assets" for several minutes while bundles stream from CDN.
- Active progress can be confirmed by tailing:
  - `.../raid-shadow-legends/build/log.txt`
- If audio starts muted/bugged, opening in-game audio settings once often re-initializes sound.

## Docs

- `docs/LESSONS_LEARNED.md`
- `docs/TROUBLESHOOTING.md`
