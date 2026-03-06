#!/usr/bin/env bash
set -euo pipefail

# One-shot bootstrap for the known-good RAID + Plarium Proton workaround flow.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALLER="${HOME}/Downloads/PlariumPlayInstaller.exe"
DO_LAUNCH=0
SKIP_INSTALL=0

usage() {
  cat <<'EOF'
Usage:
  ./scripts/bootstrap-raid-proton.sh [options]

Options:
  --installer /path/to/PlariumPlayInstaller.exe   Override installer path
  --skip-install                                  Skip installer run
  --launch                                        Launch Plarium at end
  -h, --help                                      Show help

What it does:
  1) Validates Steam Proton Experimental exists
  2) Installs Plarium Play (if needed / not skipped)
  3) Creates desktop shortcuts
  4) Reapplies RAID webview fix (if RAID files exist yet)
  5) Optionally launches Plarium Play
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --installer)
      INSTALLER="${2:-}"
      shift 2
      ;;
    --skip-install)
      SKIP_INSTALL=1
      shift
      ;;
    --launch)
      DO_LAUNCH=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage
      exit 1
      ;;
  esac
done

PROTON="${HOME}/.steam/debian-installation/steamapps/common/Proton - Experimental/proton"
PLARIUM_EXE="${HOME}/.local/share/proton-prefixes/plarium-play/pfx/drive_c/users/steamuser/AppData/Local/PlariumPlay/PlariumPlay.exe"
RAID_ARGS="${HOME}/.local/share/proton-prefixes/plarium-play/pfx/drive_c/users/steamuser/AppData/Local/PlariumPlay/StandAloneApps/raid-shadow-legends/build/Raid_Data/StreamingAssets/WebViewCommandLineArgs.txt"

echo "== Bootstrap RAID Proton =="

if [[ ! -x "$PROTON" ]]; then
  echo "Missing Proton Experimental at:" >&2
  echo "  $PROTON" >&2
  echo "Open Steam and install 'Proton - Experimental', then retry." >&2
  exit 1
fi

if [[ "$SKIP_INSTALL" -eq 0 ]]; then
  if [[ -f "$PLARIUM_EXE" ]]; then
    echo "Plarium already installed in prefix. Skipping install."
  else
    if [[ ! -f "$INSTALLER" ]]; then
      echo "Installer not found: $INSTALLER" >&2
      echo "Download PlariumPlayInstaller.exe and rerun, or pass --installer." >&2
      exit 1
    fi
    echo "Running Plarium installer..."
    "${SCRIPT_DIR}/install-plarium-proton.sh" "$INSTALLER"
  fi
else
  echo "Install step skipped by flag."
fi

echo "Creating desktop shortcuts..."
"${SCRIPT_DIR}/create-desktop-shortcuts.sh"

if [[ -f "$RAID_ARGS" ]]; then
  echo "Reapplying RAID webview fix..."
  "${SCRIPT_DIR}/reapply-raid-webview-fix.sh" "$RAID_ARGS"
else
  echo "RAID args file not found yet, skipping webview fix for now."
  echo "Run this later after launching RAID once:"
  echo "  ./scripts/reapply-raid-webview-fix.sh"
fi

if [[ "$DO_LAUNCH" -eq 1 ]]; then
  echo "Launching Plarium Play..."
  exec "${SCRIPT_DIR}/launch-plarium-proton.sh"
fi

echo "Bootstrap complete."
