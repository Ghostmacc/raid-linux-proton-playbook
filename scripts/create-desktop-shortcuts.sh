#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DESKTOP_DIR="$HOME/Desktop"
mkdir -p "$DESKTOP_DIR"

cat > "$DESKTOP_DIR/Install-Plarium-Proton.desktop" <<EOD
[Desktop Entry]
Version=1.0
Type=Application
Name=Install Plarium (Proton)
Comment=Install standalone Plarium Play using Proton Experimental
Exec=$REPO_DIR/scripts/install-plarium-proton.sh
Icon=applications-games
Terminal=true
StartupNotify=true
Categories=Game;
EOD

cat > "$DESKTOP_DIR/Plarium-Proton.desktop" <<EOD
[Desktop Entry]
Version=1.0
Type=Application
Name=Plarium Play (Proton)
Comment=Launch standalone Plarium Play using Proton Experimental
Exec=$REPO_DIR/scripts/launch-plarium-proton.sh
Icon=applications-games
Terminal=true
StartupNotify=true
Categories=Game;
EOD

cat > "$DESKTOP_DIR/Install-Raid-Steam.desktop" <<'EOD'
[Desktop Entry]
Version=1.0
Type=Application
Name=Install RAID (Steam)
Comment=Open Steam install prompt for RAID: Shadow Legends
Exec=steam steam://install/2333480
Icon=steam
Terminal=false
StartupNotify=true
Categories=Game;
EOD

cat > "$DESKTOP_DIR/Play-Raid-Steam.desktop" <<'EOD'
[Desktop Entry]
Version=1.0
Type=Application
Name=Play RAID (Steam)
Comment=Launch RAID: Shadow Legends from Steam
Exec=steam steam://rungameid/2333480
Icon=steam
Terminal=false
StartupNotify=true
Categories=Game;
EOD

chmod +x \
  "$DESKTOP_DIR/Install-Plarium-Proton.desktop" \
  "$DESKTOP_DIR/Plarium-Proton.desktop" \
  "$DESKTOP_DIR/Install-Raid-Steam.desktop" \
  "$DESKTOP_DIR/Play-Raid-Steam.desktop"

echo "Desktop shortcuts created in: $DESKTOP_DIR"
