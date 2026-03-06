#!/usr/bin/env bash
set -euo pipefail

PROTON="$HOME/.steam/debian-installation/steamapps/common/Proton - Experimental/proton"
export STEAM_COMPAT_DATA_PATH="$HOME/.local/share/proton-prefixes/plarium-play"
export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.steam/debian-installation"
EXE="$STEAM_COMPAT_DATA_PATH/pfx/drive_c/users/steamuser/AppData/Local/PlariumPlay/PlariumPlay.exe"

if [ ! -x "$PROTON" ]; then
  echo "Proton Experimental not found at: $PROTON" >&2
  exit 1
fi

if [ ! -f "$EXE" ]; then
  echo "Plarium Play executable not found at: $EXE" >&2
  echo "Run ./scripts/install-plarium-proton.sh first." >&2
  exit 1
fi

echo "Launching Plarium Play via Proton Experimental"
exec "$PROTON" run "$EXE"
