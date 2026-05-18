# Shizuku Troubleshooting Flowchart

## "App says Shizuku is not available"

```
Is Shizuku Manager app installed and running?
├─ NO → Install from F-Droid or GitHub
├─ YES → Is it in foreground when app tries to use it?
   ├─ NO → App needs to request permission first
   ├─ YES → Did you grant permission when prompted?
      ├─ NO → Open Shizuku Manager → manage permission for this app
      ├─ YES → Is it crashing?
         ├─ YES → Check logcat: adb logcat | grep Shizuku
         ├─ NO → Restart both Shizuku and the app
```

## "Shizuku keeps stopping"

```
Check Shizuku logs:
adb logcat | grep -i shizuku

Common causes:
├─ Out of memory → Disable other apps, restart Shizuku
├─ adb connection dropped → Reconnect: adb connect <ip>:5555
├─ System killed it → Check Settings → Apps → Shizuku → Battery
   └─ Disable battery optimization for Shizuku
├─ Device rebooted → Re-run adb shell sh /data/adb/shizuku/starter.sh
```

## "Permission denied" errors

```
Error: Permission denied (EPERM)
├─ App doesn't have the right permission → Check Shizuku Manager grants
├─ Shizuku not running in terminal mode → Verify it started correctly
└─ adb access revoked → Reconnect over adb

Error: SecurityException
├─ App requesting permission Shizuku can't grant → Check docs
├─ WRITE_SECURE_SETTINGS not available → This app needs root
```

## Quick recovery steps

```bash
# 1. Restart Shizuku
adb shell su -c "pkill -f 'Shizuku UserService'"
adb shell sh /data/adb/shizuku/starter.sh

# 2. Clear app cache
adb shell pm clear com.your.app

# 3. Kill and restart the app
adb shell am force-stop com.your.app
adb shell am start -n com.your.app/.MainActivity

# 4. Last resort: reinstall app
adb uninstall com.your.app
adb install app.apk
```
