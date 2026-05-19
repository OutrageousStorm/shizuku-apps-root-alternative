# Complete Shizuku Setup 2026

How to install and use Shizuku — the root alternative for Android 6+.

## Install Shizuku

```bash
# Method 1: Play Store (easiest)
# Just search "Shizuku" in Play Store

# Method 2: GitHub Releases (if Play Store unavailable)
wget https://github.com/RikkaApps/Shizuku/releases/download/v13.x.x/Shizuku-13.x.x.apk
adb install Shizuku-13.x.x.apk

# Method 3: From Terminal Emulator (no desktop needed)
# In Termux or Terminal Emulator, paste the pairing code from Shizuku app
```

## Start Shizuku

### Option A: Wireless (ADB over WiFi)
```bash
adb connect 192.168.1.x:5555   # Your device IP
# Accept connection prompt on device
```

### Option B: USB (always works)
```bash
adb shell sh /data/adb/modules/rish/rish
```

### Option C: Magisk Module (auto-start)
Install "Rish" Magisk module from repo for auto-start

## Verify it's working
```bash
adb shell sh /data/local/tmp/shizuku_starter
# Should see: "Shizuku service started"

# Or in Shizuku app:
# Settings → Binder → should show "Connected"
```

## What can Shizuku do (vs root)?

| Feature | Root | Shizuku |
|---------|------|---------|
| Grant dangerous permissions | ✓ | ✓ |
| Control background apps | ✓ | ✓ |
| Read system files | ✓ | ✓ |
| Uninstall system apps | ✓ | ✓ |
| Custom system settings | ✓ | ✗ |
| Modify SELinux policy | ✓ | ✗ |
| Load kernel modules | ✓ | ✗ |

## Best apps that use Shizuku
- **App Ops** — granular permission control
- **NetGuard** — network firewall per-app
- **Blocker** — app + notification control
- **Island** — work profile + hidden apps
- **Tasker** — system automation

## Troubleshooting

**"Shizuku service not available"**
→ Restart ADB: `adb kill-server && adb devices`

**"Permission denied" in Shizuku app**
→ Disconnect and reconnect ADB

**Lost connection after screen unlock**
→ Use USB connection instead of wireless
