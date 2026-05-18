# Shizuku App Compatibility Matrix

| App | A12 | A13 | A14 | A15 | Notes |
|-----|-----|-----|-----|-----|-------|
| **Canta** | ✅ | ✅ | ✅ | ✅ | Disable/enable apps |
| **Hail** | ✅ | ✅ | ✅ | ✅ | Freeze/unfreeze apps |
| **SetEdit** | ✅ | ✅ | ⚠️ | ⚠️ | System settings |
| **AppOps** | ✅ | ✅ | ✅ | ✅ | Permission control |
| **DeviceOwner** | ✅ | ✅ | ⚠️ | ❌ | Enterprise mode |
| **StorageRedirect** | ✅ | ✅ | ⚠️ | ❌ | File sandboxing |
| **Sideloader** | ✅ | ✅ | ✅ | ✅ | No Shizuku needed |

## Installation Order

1. Install Shizuku + wireless ADB pairing
2. Install Canta or Hail for app management
3. Install SetEdit for advanced tweaks
4. Add Greenify for battery optimization

## Known Issues

- **Canta A15**: May crash (use latest beta)
- **SetEdit A14+**: Settings revert on reboot (use Magisk module)
- **StorageRedirect A13+**: Broken (use Shelter + sandboxing)
- **DeviceOwner A15**: Doesn't work (use ADB commands)
