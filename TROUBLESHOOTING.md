# Shizuku Troubleshooting

## Installation & Setup

### "Failed to authorize" / "Permission denied"

**Cause:** Shizuku wasn't granted permission to access the API.

**Fix:**
1. Open Shizuku app
2. Go to **Settings** → **Authorize** (or tap the main button)
3. For wireless ADB method:
   - Device: Settings → Developer Options → Wireless debugging → ON
   - PC: `adb pair <device_ip>:<port> <code>` (from device screen)
   - PC: `adb connect <device_ip>:5555`
   - Open Shizuku app → tap **Start via Wireless ADB**

---

## Wireless ADB Issues

### "No pairing code shown" or "Can't pair"

**Fix:**
```bash
# Reset wireless ADB state
adb shell settings put global adb_wifi_enabled 0
adb shell settings put global adb_wifi_enabled 1
adb reboot
```

### Device shows port but pairing fails

- Ensure same Wi-Fi network
- Try: `adb unpair <ip>`
- Restart `adb` on PC: `adb kill-server && adb start-server`
- Restart device

### "Connection refused" when trying to connect

```bash
adb disconnect
adb kill-server
adb start-server
adb connect <device_ip>:5555
```

---

## Shizuku API Issues

### App crashes when using Shizuku

**Cause:** App didn't check if Shizuku API is available before using it.

**Fix (for users):**
- Make sure Shizuku is fully started (green checkmark in Shizuku app)
- Uninstall the app and reinstall
- Try another Shizuku-dependent app to see if issue is app-specific

**Fix (for developers):**
```kotlin
if (Shizuku.isAvailable()) {
    // Safe to use Shizuku
} else {
    // Fall back or show error
}
```

### "Permission denied" when running commands

**Cause:** Shizuku privilege level is too low for the command.

**Fix:**
```bash
# Try running as user vs system:
adb shell "run-as com.example" <cmd>  # user context

# vs system context — requires higher Shizuku privilege
adb shell <cmd>  # system
```

---

## Apps Not Appearing in Scope

### Installed app doesn't show in Shizuku app list

**Cause:** Shizuku cache needs refresh.

**Fix:**
- Shizuku app → Settings → Refresh scope
- Or: `adb shell pm list packages | grep <app_name>`

---

## Permissions & Capabilities

### "Cannot open file: Permission denied"

This means even Shizuku can't access that file (it has user-level permissions, not true root).

**What Shizuku CAN do:**
- Read system settings (`settings get`)
- Write non-protected settings (`settings put`)
- Use privileged APIs (launcher shortcuts, etc.)
- Control device via shell commands

**What Shizuku CANNOT do:**
- Write to `/system` partition
- Bypass SELinux
- Access truly protected files (`/root`, `/data/system`, etc.)
- Unload kernel modules

For those → you need **true root** via Magisk.

---

## Performance Issues

### Apps using Shizuku are slow

**Cause:** Wireless ADB has more latency than USB.

**Fix:**
- Use USB cable if possible (via wireless ADB over USB)
- Or just accept the latency — network calls over wireless are inherently slower
- Cache results instead of querying every time

---

## Shizuku Stops Responding

### App or Shizuku freezes

**Fix:**
```bash
# Restart Shizuku daemon
adb shell "kill $(pidof shizuku)"
# Restart the app
```

Or:
1. Open Shizuku app
2. Toggle "Stop" then "Start"
3. Restart apps using Shizuku

---

## Device Reboots

### Device reboots after setting up Shizuku

**Cause:** Malicious app or Shizuku configuration conflict.

**Fix:**
1. Boot to Recovery (hold Power + Volume Down)
2. Wipe cache partition
3. Reboot
4. Reinstall Shizuku from official source only

---

## Reporting Issues

If Shizuku itself is crashing:
1. Collect logs: `adb logcat | grep -i shizuku > logs.txt`
2. Post on [Shizuku GitHub Issues](https://github.com/RikkaApps/Shizuku/issues)
3. Include: Android version, device model, Shizuku version, steps to reproduce

---

See also: [Shizuku Setup Guide](README.md) · [Best Practices](BEST_PRACTICES.md) · [App List](APPS.md)
