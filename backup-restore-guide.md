# Backup & Restore via Shizuku

Using Shizuku, you can backup and restore apps without root.

## Full device backup

```bash
# Backup all APKs
adb shell pm list packages -3 | while read pkg; do
  pkg=${pkg#package:}
  path=$(adb shell pm path $pkg | cut -d: -f2)
  adb pull "$path" "./$pkg.apk"
done

# Backup app data (requires permission)
adb backup -f backup.ab -noapk com.example.app
```

## Restore via App Manager (Shizuku)

1. Install **App Manager** from F-Droid
2. Grant Shizuku permission in App Manager settings
3. Go to Batch Operations → Install APKs
4. Select all backed-up APK files
5. App Manager restores with Shizuku permissions

## Backup app preferences

App data stored in SharedPreferences:

```bash
# Extract per-app SharedPrefs (requires access to /data/data/)
adb shell "su -c 'cat /data/data/com.example.app/shared_prefs/com.example.app_preferences.xml'" > prefs.xml

# Via backup.ab:
adb backup -noapk com.example.app
ab2tar backup.ab | tar xvf -
# Then extract from: apps/com.example.app/shared_prefs/
```
