#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════
#  wireless-adb-setup.sh
#  Set up ADB over Wi-Fi so Shizuku can run without a USB cable
#  Works on Android 10 and below (Android 11+ has built-in wireless ADB)
# ═══════════════════════════════════════════════════════════

BOLD='\033[1m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'; NC='\033[0m'

banner() {
  echo -e "${BOLD}"
  echo "  ╔══════════════════════════════════════╗"
  echo "  ║  📡 Wireless ADB Setup for Shizuku   ║"
  echo "  ╚══════════════════════════════════════╝"
  echo -e "${NC}"
}

banner

# Check device connected via USB first
device=$(adb devices | grep -v "^List" | grep "device$" | awk '{print $1}' | head -1)
if [[ -z "$device" ]]; then
  echo -e "${YELLOW}❌ Connect device via USB first to set up wireless ADB${NC}"
  exit 1
fi

# Get device's IP address
echo -e "${CYAN}Detecting device IP address...${NC}"
ip=$(adb shell ip route | awk '/wlan/{print $9}' | head -1)
if [[ -z "$ip" ]]; then
  ip=$(adb shell ifconfig wlan0 2>/dev/null | grep "inet addr" | awk '{print $2}' | cut -d: -f2)
fi
if [[ -z "$ip" ]]; then
  ip=$(adb shell ip addr show wlan0 | grep "inet " | awk '{print $2}' | cut -d/ -f1)
fi

if [[ -z "$ip" ]]; then
  echo -e "${YELLOW}⚠ Could not auto-detect IP. Find it in Settings > About Phone > Status${NC}"
  read -rp "Enter device IP: " ip
fi

echo -e "${GREEN}  Device IP: $ip${NC}"

# Enable TCP/IP mode on port 5555
PORT=5555
echo -e "${CYAN}Enabling TCP/IP mode on port $PORT...${NC}"
adb tcpip $PORT
sleep 2

# Connect wirelessly
echo -e "${CYAN}Connecting wirelessly...${NC}"
result=$(adb connect "$ip:$PORT")
echo -e "${GREEN}  $result${NC}"

# Disconnect USB prompt
echo ""
echo -e "${BOLD}✅ Wireless ADB connected!${NC}"
echo -e "   IP: $ip:$PORT"
echo -e "   ${YELLOW}You can now unplug the USB cable.${NC}"
echo ""
echo -e "${CYAN}Now open Shizuku and tap: '通过无线调试启动' / 'Start via Wireless Debugging'${NC}"
echo ""
echo -e "To reconnect later (after reboot):"
echo -e "  adb connect $ip:$PORT"
