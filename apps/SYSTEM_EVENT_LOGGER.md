# System Event Logger (Shizuku App)

Real-time system event monitoring using Shizuku UserService — no root needed.

## What It Does

- Logs WiFi connect/disconnect events
- Tracks app foreground/background transitions
- Monitors battery level changes
- Records notification events
- Exports events to JSON/CSV

## Installation

```bash
# Install Shizuku first
# Then install this app (via APK or source)
# Grant it Shizuku permissions when prompted
```

## Usage

```kotlin
// Initialize with Shizuku UserService
val eventLogger = SystemEventLogger(userService)

// Start listening
eventLogger.listen { event ->
    when (event.type) {
        EventType.APP_FOREGROUND -> log("App opened: ${event.packageName}")
        EventType.WIFI_CONNECTED -> log("WiFi: ${event.data}")
        EventType.BATTERY_CHANGED -> log("Battery: ${event.data}%")
    }
}

// Export to file
eventLogger.exportJSON("/sdcard/events.json")
```

## Implementation

Uses Android's hidden APIs through Shizuku:

```
com.android.internal.content.IntentFilter
android.app.IActivityManager.registerProcessObserver()
android.content.Intent.ACTION_BATTERY_CHANGED
```

This allows UserService-level access to system broadcasts without root.

## Data Format

```json
{
  "timestamp": 1684503600000,
  "type": "APP_FOREGROUND",
  "package": "com.spotify.music",
  "uid": 10001
}
```

Perfect for battery analysis, usage tracking, or security auditing without needing root.
