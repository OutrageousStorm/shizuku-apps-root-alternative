# Shizuku Setup Guide

Shizuku is a system service that runs with ADB privilege without requiring root.

## Install Shizuku

1. **Download APK:** https://github.com/rikka-x/Shizuku/releases
2. **Install:** `adb install Shizuku-v*.apk`
3. **Start the service:**
   ```bash
   adb shell sh /sdcard/Android/data/moe.shizuku.privileged.api/start.sh
   ```
   Or via USB wireless debugging (Android 11+):
   - Settings → Developer Options → Wireless debugging → enable
   - Settings → Shizuku → Wireless ADB debugging
   - Generate pairing code, pair, then enable

## Apps that work with Shizuku

| App | Function | Download |
|-----|----------|----------|
| **App Manager** | Full app control, permissions, component ops | [GitHub](https://github.com/MuntashirAkon/AppManager) |
| **Shelter** | Work profile + app freezing | [F-Droid](https://f-droid.org/packages/net.noisygecko.shelter) |
| **Hail** | Disable/hide/suspend apps without root | [GitHub](https://github.com/aistra0528/Hail) |
| **LSPosed** | Xposed framework alternative | [GitHub](https://github.com/LSPosed/LSPosed) |
| **Magisk** | Grant shell access for modules | With Zygisk |
| **Getrekt** | System-wide gesture detection | [GitHub](https://github.com/GetrektPL/Getrekt) |

## Permissions Shizuku grants

- `pm` (package manager) — install/uninstall/grant/revoke
- `settings` — read/write system settings
- `dumpsys` — full system diagnostics
- Shell access level — equivalent to `adb shell` user
