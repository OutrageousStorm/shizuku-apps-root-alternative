# Shizuku API Reference

Complete guide to using Shizuku in your Android app.

## Setup in your app

### 1. Add AIDL interface

Create `src/main/aidl/moe/shizuku/server/IUserService.aidl`:

```aidl
package moe.shizuku.server;

interface IUserService {
    void destroy();
}
```

### 2. Create UserService implementation

```kotlin
class MyUserService : IUserService.Stub() {
    override fun destroy() {
        // Clean up
    }
}
```

### 3. Request binder in your Activity

```kotlin
import moe.shizuku.api.ShizukuProvider

ShizukuProvider.requestBinder(executor) { binder ->
    if (binder != null) {
        val service = IUserService.Stub.asInterface(binder)
        // Use service
    }
}
```

## Common operations

### Get UID/GID context
```kotlin
val uid = Binder.getCallingUid()
val pid = Binder.getCallingPid()
```

### Execute shell command
```kotlin
val proc = Runtime.getRuntime().exec("your-command")
val output = proc.inputStream.bufferedReader().readText()
```

### Modify system settings
```kotlin
// Requires pm grant com.app android.permission.WRITE_SECURE_SETTINGS
val resolver = context.contentResolver
resolver.call(Settings.System.CONTENT_URI, "insert", null, mapOf(
    Settings.System.NAME to "setting_name",
    Settings.System.VALUE to "value"
).toContentValues())
```

## Permission requirements

Common Shizuku permissions:
- `android.permission.WRITE_SECURE_SETTINGS` — modify system settings
- `android.permission.PACKAGE_USAGE_STATS` — see app usage
- `android.permission.CHANGE_DEVICE_ADMIN` — DeviceAdmin APIs

## Error handling

```kotlin
try {
    ShizukuProvider.requestBinder(executor) { binder ->
        // ...
    }
} catch (e: ShizukuProvider.PreImeUnavailableException) {
    // Shizuku not available
    Toast.makeText(this, "Shizuku not available", Toast.LENGTH_SHORT).show()
}
```

## Resources
- [Shizuku GitHub](https://github.com/RikkaApps/Shizuku)
- [Shizuku Example App](https://github.com/RikkaApps/Shizuku-Example)
