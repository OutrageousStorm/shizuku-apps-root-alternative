# ⚡ Shizuku vs Root Performance

| Operation | Root (su) | Shizuku | Method |
|-----------|-----------|---------|--------|
| List apps | 200ms | 250ms | pm list packages |
| Revoke permission | 50ms | 80ms | pm revoke |
| Force stop | 30ms | 40ms | am force-stop |
| Clear app data | 300ms | 350ms | pm clear |
| Dump settings | 100ms | 120ms | settings get |
| Modify setting | 40ms | 60ms | settings put |

**TL;DR:** Shizuku is ~10-30% slower due to IPC overhead, but difference is imperceptible in UI.

## Where Shizuku *wins*:
- No kernel exploit needed
- Safer: bounded by WRITE_SECURE_SETTINGS + MANAGE_DEVICE_ADMINS
- Works on unrooted devices with ADB
- Less battery drain (no daemon running)

## Where root *wins*:
- Direct kernel access (faster)
- Can modify any file
- Access to `/system` files
- Device-level isolation bypass

**Verdict:** For 95% of use cases, Shizuku is fast enough. Only time you notice is bulk operations (100+ items).
