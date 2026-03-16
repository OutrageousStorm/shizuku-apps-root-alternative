#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════
#  grant-shizuku-perms.sh
#  Grant Shizuku WRITE_SECURE_SETTINGS permission via ADB
#  Required for many Shizuku apps to function fully
# ═══════════════════════════════════════════════════════════

BOLD='\033[1m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

APPS=(
  "moe.shizuku.privileged.api"       # Shizuku core
  "com.kieronquinn.app.smartspacer"  # Smartspacer
  "com.tribalfs.msa"                 # MSA (Mixed Settings Adapter)
  "app.lawnchair.lawnicons"          # Lawnicons
  "com.aiqfome.android.colorBlendr"  # ColorBlendr
  "com.judopro.systemui.tuner"       # System UI Tuner
)

echo -e "${BOLD}Granting Shizuku permissions to known apps...${NC}"
echo ""

for pkg in "${APPS[@]}"; do
  installed=$(adb shell pm list packages 2>/dev/null | grep "^package:$pkg$")
  if [[ -n "$installed" ]]; then
    adb shell pm grant "$pkg" android.permission.WRITE_SECURE_SETTINGS 2>/dev/null
    echo -e "${GREEN}  ✓ Granted${NC} WRITE_SECURE_SETTINGS → $pkg"
  else
    echo -e "  ○ Not installed: $pkg"
  fi
done

echo ""
echo -e "${BOLD}Granting to your custom app:${NC}"
echo "  Usage: $0 com.your.package.name"
if [[ -n "$1" ]]; then
  adb shell pm grant "$1" android.permission.WRITE_SECURE_SETTINGS
  echo -e "${GREEN}  ✓ Granted to $1${NC}"
fi
