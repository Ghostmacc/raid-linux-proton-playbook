# Lessons Learned

## 1) Steam path works, but account behavior can be constrained

Running `steam://rungameid/2333480` launches RAID reliably, but account routing may stay Steam-contextual in ways that are not ideal when you need explicit Plarium Play login control.

## 2) Dedicated Proton prefix for Plarium Play is the stable workaround

Using Proton Experimental with a dedicated compat prefix gives predictable paths and avoids collisions:

- `STEAM_COMPAT_DATA_PATH=~/.local/share/proton-prefixes/plarium-play`
- `STEAM_COMPAT_CLIENT_INSTALL_PATH=~/.steam/debian-installation`

Then run:
- installer: `PlariumPlayInstaller.exe`
- launcher: `PlariumPlay.exe`

## 3) Bottles can be usable but was less stable in this run

We saw intermittent transparent windows/hangs while experimenting in Bottles profiles. Steam Proton path was more reproducible for this session.

## 4) "Loading assets" is often real progress, not a deadlock

When unsure, use process + log checks:
- `Raid.exe` with sustained CPU usually means active loading
- `log.txt` should show constant `AssetBundleLoader` activity

## 5) Keep bootstrap reproducible for new hardware

Automate the known-good path with scripts and template `.desktop` launchers so setup can be repeated quickly on a fresh machine.
