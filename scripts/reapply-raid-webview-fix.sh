#!/usr/bin/env bash
set -euo pipefail

# Reapply the RAID Vuplex WebView workaround after game updates overwrite args.

PREFIX="${RAID_PROTON_PREFIX:-$HOME/.local/share/proton-prefixes/plarium-play}"
TARGET_FILE="${1:-}"

usage() {
  cat <<'EOF'
Usage:
  ./scripts/reapply-raid-webview-fix.sh [path/to/WebViewCommandLineArgs.txt]

Behavior:
  - With no argument: auto-detects the latest RAID args file under the Proton prefix.
  - With a file argument: patches that exact file.

Optional env:
  RAID_PROTON_PREFIX=/custom/prefix/root
EOF
}

if [[ "${TARGET_FILE:-}" == "-h" || "${TARGET_FILE:-}" == "--help" ]]; then
  usage
  exit 0
fi

if [[ -z "${TARGET_FILE}" ]]; then
  mapfile -t candidates < <(
    find "$PREFIX" \
      -type f \
      -path "*/raid-shadow-legends/build/Raid_Data/StreamingAssets/WebViewCommandLineArgs.txt" \
      2>/dev/null
  )

  if [[ ${#candidates[@]} -eq 0 ]]; then
    echo "No RAID WebViewCommandLineArgs.txt found under: $PREFIX" >&2
    echo "Launch RAID once (or pass explicit file path) and retry." >&2
    exit 1
  fi

  TARGET_FILE="$(ls -t "${candidates[@]}" | head -n 1)"
fi

if [[ ! -f "$TARGET_FILE" ]]; then
  echo "Target file not found: $TARGET_FILE" >&2
  exit 1
fi

desired_args='--disable-smooth-scrolling
--zf-log-cef-verbose
--zf-log-internal
--single-process
--disable-features=NetworkServiceSandbox
--disable-gpu-sandbox
--no-sandbox'

current_contents="$(cat "$TARGET_FILE" || true)"
if [[ "$current_contents" == "$desired_args" ]]; then
  echo "Already patched: $TARGET_FILE"
  exit 0
fi

backup="${TARGET_FILE}.bak.$(date +%Y%m%d-%H%M%S)"
cp -a "$TARGET_FILE" "$backup"
printf '%s\n' "$desired_args" > "$TARGET_FILE"

echo "Patched: $TARGET_FILE"
echo "Backup:  $backup"
echo
echo "Current args:"
cat "$TARGET_FILE"
