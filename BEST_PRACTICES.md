# ✅ Shizuku Best Practices & Troubleshooting

## Common Issues & Fixes

### "Shizuku service not responding"
```bash
# Force restart Shizuku
adb shell killall shizuku
# Re-open Shizuku app and wait 10s
```

### "Permission denied" when running commands
```bash
# Ensure Shizuku app has user exec permission
adb shell pm grant moe.shizuku.privileged.api android.permission.WRITE_EXTERNAL_STORAGE

# Then try again
```

### "Cannot connect via wireless ADB"
```bash
# Verify pairing code is correct and device is on same network
adb pair <ip>:<port> <code>

# Then connect
adb connect <ip>:5555

# Verify connection
adb devices
```

## Performance Tips

1. **Don't run heavy loops via Shizuku**
   - Each `adb shell` call has ~100-200ms overhead
   - Batch commands when possible

2. **Use native Shizuku API when available**
   - Calling `pm` via Shizuku is slower than native app integration
   - Consider Shizuku libraries for your app instead of shell commands

3. **Cache results**
   - Don't call `pm list packages` repeatedly
   - Store and update periodically

## Security Notes

- **Shizuku has broad access** — review what apps you grant permissions to
- **Wireless ADB is less secure** — only use on trusted networks
- **Module permissions** — LSPosed modules can hook anything — vet before installing

## Integration with Your Apps

```bash
# Grant Shizuku API permission to your app
adb shell pm grant com.your.app moe.shizuku.manager.permission.API_V23

# Your app can then call Shizuku directly without asking user
```

## When NOT to Use Shizuku

- Need UID-level access (storage isolation)
- Modifying `/system` files
- Changing SELinux context
- Accessing other app private data

**→ These require actual root.**

