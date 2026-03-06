# Troubleshooting

## Proton not found

Expected path:

`~/.steam/debian-installation/steamapps/common/Proton - Experimental/proton`

Fix:
1. Open Steam
2. Install `Proton - Experimental`
3. Re-run script

## Plarium installer not found

Expected file:

`~/Downloads/PlariumPlayInstaller.exe`

Fix:
- Download from Plarium website and place at that path.

## Plarium launcher opens then disappears

1. Kill stuck launcher processes:

```bash
pkill -f 'C:\\users\\steamuser\\AppData\\Local\\PlariumPlay\\PlariumPlay.exe' || true
```

2. Relaunch:

```bash
./scripts/launch-plarium-proton.sh
```

## RAID stuck on loading assets

Check process:

```bash
ps -eo pid,etime,pcpu,args | rg -i 'Raid.exe|PlariumPlay|proton|wine' | rg -v rg
```

Check live log:

```bash
tail -n 80 ~/.local/share/proton-prefixes/plarium-play/pfx/drive_c/users/steamuser/AppData/Local/PlariumPlay/StandAloneApps/raid-shadow-legends/build/log.txt
```

If log lines continue (`AssetBundleLoader` loaded/loading), wait.

## No audio until opening settings

Known issue seen in session. Workaround: open in-game audio settings once after startup to force re-init.

## Tournaments / Events timeout

If Tournaments or Events fail with connection timeout after an update, reapply the webview args fix:

```bash
./scripts/reapply-raid-webview-fix.sh
```

If needed, pass the exact args file:

```bash
./scripts/reapply-raid-webview-fix.sh "/path/to/WebViewCommandLineArgs.txt"
```
