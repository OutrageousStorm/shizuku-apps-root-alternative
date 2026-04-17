# Shizuku Setup Guide

## Prerequisites
- Android 6.0+ (better on 11+ for wireless ADB)
- USB cable or wireless ADB enabled
- Shizuku app installed

---

## Method 1: Wireless ADB (Android 11+) — Easiest

1. **Enable Wireless Debugging on device:**
   - Settings → Developer Options → Wireless Debugging → ON
   - Tap "Pair with pairing code"
   - Note the IP address and pairing code

2. **Open Shizuku app → Start using Shizuku**
   - It auto-detects and prompts for pairing
   - Enter the pairing code when prompted

3. **Done** — Shizuku now runs over ADB without USB cable

---

## Method 2: USB ADB (All Android versions)

1. **On PC, download Shizuku start script:**
   ```bash
   adb shell "cat /sdcard/Android/data/moe.shizuku.privileged.api/start.sh"
   ```

2. **Or from GitHub:**
   ```bash
   adb push start.sh /sdcard/
   adb shell sh /sdcard/start.sh
   ```

3. **Allow when Shizuku prompts on device**

4. **Shizuku is now running** — you can disconnect USB

---

## Granting Shizuku Access to Apps

1. Open the app that requests Shizuku access
2. A dialog appears: "Grant Shizuku access?"
3. Tap **Shizuku Manager** shortcut in notification → approve
4. Done — app now has elevated privileges

---

## Common Issues

**"Shizuku not running"**
- Make sure Shizuku app is installed and has Wireless Debugging auth
- Re-run the start script via USB ADB

**App says "Permission denied"**
- Check Shizuku Manager → see if app is in the list
- Re-grant permission and restart the app

**Wireless pairing failed**
- Make sure PC and phone are on same network
- Try pairing again with new code
- If stuck, use USB method instead

---

## Advanced: Automated Shizuku Setup

Script to auto-pair Shizuku via ADB:
```bash
#!/bin/bash
adb shell settings put global adb_enabled 1
adb shell settings put global secure_adb_enabled 1
adb shell sh /sdcard/Android/data/moe.shizuku.privileged.api/start.sh
echo "✓ Shizuku started. Allow on device."
sleep 3
adb shell am start moe.shizuku.privileged.api/.GrantActivity
```

Save as `setup_shizuku.sh` and run whenever you need to restart Shizuku.
