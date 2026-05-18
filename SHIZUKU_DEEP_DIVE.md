# Shizuku Deep Dive: How It Works

## Architecture

```
┌─────────────────────────────────┐
│  Your App (target)              │
│  • Uses ShizukuProvider API      │
│  • Calls binder.transact()      │
└──────────────┬──────────────────┘
               │
       Binder IPC
               │
┌──────────────▼──────────────────┐
│  Shizuku UserService (daemon)   │
│  • Privileged shell process     │
│  • Runs: /system/app/Shizuku    │
│  • Can execute any shell cmd    │
└──────────────┬──────────────────┘
               │
       Direct shell execution
               │
┌──────────────▼──────────────────┐
│  System shell (uid=2000)        │
│  • pm uninstall --user 0        │
│  • settings put secure ...      │
│  • dumpsys ...                  │
└─────────────────────────────────┘
```

## Key APIs

### ShizukuProvider (Intent-based)
```kotlin
// Old API — deprecated but still works
val provider = ShizukuProvider()
provider.bindService(...)
val binder = ShizukuProvider.getBinder()
```

### ShizukuSystemService (modern)
```kotlin
val binder = ShizukuSystemService.asBinder()
val shellService = IShizukuSystemService.Stub.asInterface(binder)
val result = shellService.exec("pm list packages")
```

## How Shizuku gets root-like powers

1. **Setup.sh execution** — On first install, Shizuku asks you to run a setup script via ADB:
   ```bash
   adb shell sh /path/to/setup.sh
   ```
   This script sets up a privileged UserService.

2. **UserService registration** — Android allows system apps to register UserServices. Shizuku registers itself as a system-privileged service.

3. **IPC via Binder** — Your app communicates with the Shizuku daemon via Android's Binder protocol (similar to how system services work).

4. **Shell command execution** — Shizuku's daemon runs `sh -c "your command"` and returns stdout/stderr.

## Limits

- ❌ Cannot write to `/system` (read-only)
- ❌ Cannot install system APKs (need write access)
- ✅ Can uninstall per-user
- ✅ Can read/write `/data`
- ✅ Can execute most shell commands
- ✅ Can grant/revoke app permissions
- ✅ Can access `settings` database
- ✅ Can trigger SELinux denials (can't bypass SELinux, but can log them)

## vs Root (difference)

| Feature | Shizuku | Root |
|---------|---------|------|
| Shell elevation | ✅ Yes | ✅ Yes |
| Modify `/system` | ❌ No | ✅ Yes |
| System boot hooks | ❌ No | ✅ Yes (via init.d) |
| Kernel access | ❌ No | ✅ Yes |
| Detection evasion | ✅ Easier | ❌ Harder |
| Setup complexity | ⭐ Simple | ⭐⭐⭐ Complex |
| Stability | ⭐⭐⭐⭐ High | ⭐⭐⭐ Variable |

## Example: Permission grant via Shizuku

```kotlin
// App wants to grant a permission to another app
val binder = ShizukuSystemService.asBinder()
val service = IShizukuSystemService.Stub.asInterface(binder)

// Execute: pm grant com.example.app android.permission.CAMERA
val result = service.exec("pm grant com.example.app android.permission.CAMERA")
Log.d("Shizuku", result.stdout)
```

Compare to root:
```bash
# With root (adb)
adb shell su -c "pm grant com.example.app android.permission.CAMERA"

# With Shizuku (no root, no adb)
// Just call the service from your app
```

## Best use cases

- ✅ Permission management (revoke/grant)
- ✅ Package management (uninstall per-user)
- ✅ Settings tweaking (no-root tweaker apps)
- ✅ Device administration
- ✅ ADB replacement (when PC not available)
- ❌ ROM modding (needs system write)
- ❌ Kernel tweaking (needs root)
- ❌ Xposed/LSPosed (needs root)
