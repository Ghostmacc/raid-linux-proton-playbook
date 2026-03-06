#!/usr/bin/env bash
set -euo pipefail

PROTON="$HOME/.steam/debian-installation/steamapps/common/Proton - Experimental/proton"
INSTALLER="${1:-$HOME/Downloads/PlariumPlayInstaller.exe}"
export STEAM_COMPAT_DATA_PATH="$HOME/.local/share/proton-prefixes/plarium-play"
export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.steam/debian-installation"

mkdir -p "$STEAM_COMPAT_DATA_PATH"

if [ ! -x "$PROTON" ]; then
  echo "Proton Experimental not found at: $PROTON" >&2
  exit 1
fi

if [ ! -f "$INSTALLER" ]; then
  echo "Installer not found at: $INSTALLER" >&2
  echo "Pass installer path explicitly: $0 /path/to/PlariumPlayInstaller.exe" >&2
  exit 1
fi

echo "Using Proton: $PROTON"
echo "Using installer: $INSTALLER"
exec "$PROTON" run "$INSTALLER"
