# Best Shizuku Apps (2026)

Curated list of essential Shizuku-powered apps that work without root.

## System management

| App | What it does | Rating | Link |
|-----|-------------|--------|------|
| **App Ops** | Fine-grained permission control (replacement for XPrivacy) | ⭐⭐⭐⭐⭐ | [F-Droid](https://f-droid.org/en/packages/com.jhk.appops/) |
| **Blocker** | Kill/freeze apps via Shizuku (no root needed) | ⭐⭐⭐⭐⭐ | [GitHub](https://github.com/lihenggui/Blocker) |
| **Activity Manager** | Kill background apps, force-stop, monitor RAM | ⭐⭐⭐⭐ | [Play Store](https://play.google.com/store/apps/details?id=com.activitymanager) |
| **Permission Controller** | Revoke perms from system apps (Magisk/Shizuku) | ⭐⭐⭐⭐ | [F-Droid](https://f-droid.org/packages/pm.wasted.tools.permissioncontroller) |
| **Wireless ADB** | ADB over WiFi without USB | ⭐⭐⭐⭐⭐ | [GitHub](https://github.com/RikkaApps/WirelessADBClient) |

## Storage & backup

| App | Rating | Notes |
|-----|--------|-------|
| **Syncthing** | ⭐⭐⭐⭐⭐ | Continuous file sync (privacy-first) |
| **Nextcloud** | ⭐⭐⭐⭐ | Self-hosted cloud backup + sync |
| **Neo Backup** | ⭐⭐⭐⭐⭐ | Advanced backup (no cloud, local only) |
| **SetEdit** | ⭐⭐⭐⭐ | Edit Android settings/databases directly |
| **AppWatcher** | ⭐⭐⭐⭐ | Monitor app installations + updates |

## Privacy & security

| App | Rating | Purpose |
|-----|--------|---------|
| **NetGuard** | ⭐⭐⭐⭐⭐ | Per-app firewall (no Shizuku needed but enhances) |
| **Rethink DNS** | ⭐⭐⭐⭐⭐ | DNS/firewall, blocks ads + trackers |
| **IMSI-Catcher Detector** | ⭐⭐⭐⭐ | Detect stingray towers |
| **Trackercontrol** | ⭐⭐⭐⭐ | Monitor + block tracker connections |
| **Shelter** | ⭐⭐⭐⭐ | Island/dual-profile isolation (Shizuku enhances) |

## Developer tools

| App | Rating | What it does |
|-----|--------|-------------|
| **Mitmproxy** | ⭐⭐⭐⭐⭐ | Full HTTPS intercept proxy |
| **Logcat Reader** | ⭐⭐⭐⭐ | Browse system logs + crashes |
| **WireGuard** | ⭐⭐⭐⭐⭐ | VPN + test tunneling (Shizuku mode works without root) |
| **Frida Server** | ⭐⭐⭐⭐⭐ | Dynamic instrumentation (requires root OR Shizuku) |
| **Packet Capture** | ⭐⭐⭐⭐ | TCP/UDP packet sniffer (VPN mode) |

## Performance & battery

| App | Rating | Purpose |
|-----|--------|---------|
| **Tasker** (paid) | ⭐⭐⭐⭐⭐ | Automation engine — works best with Shizuku |
| **Greenify** | ⭐⭐⭐⭐ | Hibernate background apps |
| **Scenes** | ⭐⭐⭐⭐ | Context-based automation (battery, WiFi, time) |
| **GMS Cleaner** | ⭐⭐⭐⭐ | Remove Google Play Services bloat |

## Setup instructions

### Install Shizuku first
1. Download [Shizuku](https://github.com/RikkaApps/Shizuku) from GitHub
2. Install APK: `adb install shizuku.apk`
3. Grant Shizuku permission: `adb shell sh /sdcard/shizuku_setup.sh`
4. Restart device, open Shizuku app

### Install a Shizuku app
Most Shizuku apps auto-detect if Shizuku is available:
1. Install the app from F-Droid or GitHub
2. Open app → it will ask to grant Shizuku permission
3. Tap "Grant" in Shizuku notification

### Troubleshooting

| Issue | Fix |
|-------|-----|
| App says "Shizuku not detected" | Restart Shizuku app or device |
| Permission denied | Make sure Shizuku app has permission to grant (check notification) |
| App crashes when using Shizuku | Try reloading: Settings → Apps → Shizuku → Force stop & restart |
| Wireless ADB not working | Make sure both devices on same WiFi + correct IP |

## Best combo for privacy

1. **NetGuard** — block ads + tracker IPs
2. **Rethink DNS** — DNS filtering (ads, malware, tracking)
3. **Trackercontrol** — see which apps contact which trackers
4. **Shelter** — isolate untrusted apps in a profile
5. **Greenify** — hibernate apps you don't trust
6. **Tasker** — automate disabling WiFi/location when screen off

This gives you root-like control **without root**.
