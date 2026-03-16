#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════
#  shizuku-check.sh — Verify Shizuku is running & accessible
# ═══════════════════════════════════════════════════════════

GREEN='\033[0;32m'; RED='\033[0;31m'; YELLOW='\033[1;33m'; NC='\033[0m'; BOLD='\033[1m'

check() {
  if ! command -v adb &>/dev/null; then
    echo -e "${RED}❌ ADB not found${NC}. Install: https://developer.android.com/tools/releases/platform-tools"
    exit 1
  fi
  
  local device
  device=$(adb devices | grep -v "^List" | grep "device$" | awk '{print $1}' | head -1)
  if [[ -z "$device" ]]; then
    echo -e "${RED}❌ No device connected${NC}"
    exit 1
  fi
  echo -e "${GREEN}✓ Device:${NC} $device"

  local shizuku_pkg="moe.shizuku.privileged.api"
  local installed
  installed=$(adb shell pm list packages | grep "$shizuku_pkg")
  if [[ -z "$installed" ]]; then
    echo -e "${RED}❌ Shizuku not installed${NC}"
    echo -e "   Install from: https://github.com/RikkaApps/Shizuku/releases"
    exit 1
  fi
  echo -e "${GREEN}✓ Shizuku installed${NC}"

  # Check if running
  local running
  running=$(adb shell dumpsys activity services | grep -i shizuku | head -1)
  if [[ -n "$running" ]]; then
    echo -e "${GREEN}✓ Shizuku service is running${NC}"
  else
    echo -e "${YELLOW}⚠ Shizuku may not be running${NC}"
    echo -e "   Open Shizuku app and tap 'Start via ADB / Wireless Debugging'"
  fi

  # Check version
  local version
  version=$(adb shell dumpsys package "$shizuku_pkg" | grep versionName | head -1 | tr -d ' ' | cut -d= -f2)
  echo -e "${GREEN}✓ Shizuku version:${NC} $version"
  
  echo ""
  echo -e "${BOLD}Shizuku is ready! You can now use Shizuku-powered apps.${NC}"
}

check
