# SetEdit — Edit any Android setting without root

SetEdit + Shizuku = edit `secure.db`, `global.db`, `system.db` directly.

## How it works
```bash
# Shizuku grants elevated access to content providers
# SetEdit uses that to read/write settings the normal API won't allow
```

## Common settings to edit

```
secure.location_mode = 0         # Location off
global.wifi_scan_always = 0      # WiFi scan off
secure.show_ime_with_hard_keyboard = 0  # IME on hardware keyboard
system.screen_brightness = 200   # Max brightness
global.animator_duration_scale = 0.5    # Fast animations
```

## Usage
1. Install Shizuku
2. Install SetEdit
3. Grant Shizuku permission in SetEdit
4. Edit any setting directly

Replaces: root shell access, Magisk module tinkering, ADB shell settings.
