# 📁 Scripts

Helper scripts for setting up and using Shizuku. Run from your computer with ADB installed.

| Script | Description |
|--------|-------------|
| `shizuku-check.sh` | Verify Shizuku is installed and running on your device |
| `grant-shizuku-perms.sh` | Grant `WRITE_SECURE_SETTINGS` to popular Shizuku apps via ADB |
| `wireless-adb-setup.sh` | Set up wireless ADB so Shizuku runs cable-free |

## Usage

```bash
# Check if Shizuku is ready
bash shizuku-check.sh

# Grant permissions to popular apps
bash grant-shizuku-perms.sh

# Grant to a specific app
bash grant-shizuku-perms.sh com.your.app

# Set up wireless ADB
bash wireless-adb-setup.sh
```

## Requirements
- ADB installed: https://developer.android.com/tools/releases/platform-tools
- USB Debugging enabled on your Android device
- For wireless ADB: device on the same Wi-Fi network
