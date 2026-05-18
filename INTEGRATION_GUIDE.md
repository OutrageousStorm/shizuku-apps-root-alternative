# Shizuku Integration Guide for App Developers

How to use Shizuku APIs in your Android app for elevated operations.

## Setup

Add to `build.gradle`:
```gradle
dependencies {
    implementation "dev.rikka.shizuku:api:13.0.0"
}
```

Add to `AndroidManifest.xml`:
```xml
<uses-permission android:name="moe.shizuku.permission.API_V23" />
```

## Check if Shizuku is available

```kotlin
import dev.rikka.shizuku.Shizuku
import android.content.pm.PackageManager

fun isShizukuAvailable(): Boolean {
    return runCatching {
        Shizuku.checkSelfPermission() == PackageManager.PERMISSION_GRANTED
    }.getOrNull() == true
}
```

## Execute shell commands

```kotlin
fun executeShellCommand(cmd: String): String {
    val process = Shizuku.newProcess(
        arrayOf("/bin/sh", "-c", cmd),
        null,
        null
    )
    val result = process.inputStream.bufferedReader().readText()
    process.waitFor()
    return result
}
```

## Grant permissions to apps

```kotlin
fun grantPermission(packageName: String, permission: String) {
    val result = Shizuku.newProcess(
        arrayOf("pm", "grant", packageName, permission),
        null,
        null
    ).waitFor()
}
```

## Common Shizuku apps

- **SetEdit** — Modify hidden system settings
- **Canta** — Control notifications without root
- **Hail** — Disable/freeze apps
- **Tasker** — Advanced automation
- **WiFi ADB** — Enable ADB over WiFi

## Best practices

1. Always check permission before using Shizuku
2. Handle permission denial gracefully
3. Provide fallback without Shizuku
4. Disclose what operations you perform
5. Don't abuse for spyware or tracking

See also: [Shizuku GitHub](https://github.com/RikkaApps/Shizuku)
