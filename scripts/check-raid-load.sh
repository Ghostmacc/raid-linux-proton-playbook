#!/usr/bin/env bash
set -euo pipefail

LOG="$HOME/.local/share/proton-prefixes/plarium-play/pfx/drive_c/users/steamuser/AppData/Local/PlariumPlay/StandAloneApps/raid-shadow-legends/build/log.txt"

echo "== Processes =="
ps -eo pid,etime,pcpu,pmem,args | rg -i 'plarium|raid|proton|wine|wineserver' | rg -v rg || true

echo
echo "== Recent Log =="
if [ -f "$LOG" ]; then
  tail -n 80 "$LOG"
else
  echo "Log missing: $LOG"
fi
