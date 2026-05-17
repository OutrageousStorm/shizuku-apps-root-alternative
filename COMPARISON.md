# Shizuku vs Root vs Magisk vs LSPosed

Quick comparison of privilege escalation methods for Android customization.

| Capability | Shizuku | Magisk | LSPosed | Root (su) |
|-----------|---------|--------|---------|-----------|
| **App uninstall** | ✓ (via pm) | ✓ | ✗ | ✓ |
| **Permission revoke** | ✓ (via pm) | ✓ | ✗ | ✓ |
| **System tweaks** | ✓ (settings) | ✓ | ✗ | ✓ |
| **App hooks/mods** | ✗ | ✓ (via Zygisk) | ✓ | ✓ |
| **System overlay** | ✓ (Iconify) | ✓ | ✓ (LSPosed) | ✓ |
| **Requires unlock** | ✗ | ✓ | ✓ | ✓ |
| **OTA compatible** | ✓ | ✓ | ✓ | ✗ |
| **Hidden from apps** | ✓ | ~ (DenyList) | ✓ | ✗ |
| **Wireless setup** | ✓ (ADB) | ✗ | ✗ | ✗ |
| **Survives reboot** | ✗ (needs ADB) | ✓ (persistent) | ✓ (via Magisk) | ✗ |
| **Works on iOS** | ✗ | ✗ | ✗ | ✗ |

## What each is best for

### Shizuku
- **Best for**: Minimal invasiveness, portable setup (works across devices), privacy tools
- **Examples**: NetGuard (firewall), SetEdit (system settings), Permission Lister
- **Downside**: Temporary — requires ADB connection to reactivate per session

### Magisk
- **Best for**: Permanent root, module ecosystem, OTA-safe modifications
- **Examples**: Adblock modules, custom ROMs, GMS replacements
- **Downside**: Requires unlocked bootloader, voids some warranties

### LSPosed
- **Best for**: Deep app hooking, system-wide modifications, complex behavior changes
- **Examples**: Xposed modules, app mods (YouTube ad block, app modifiers)
- **Downside**: Requires Magisk + Zygisk to run

### Plain Root (su)
- **Best for**: Maximum control, emergency recovery, one-off tweaks
- **Downside**: Not persistent, breaks OTA, no standard interface, risky

## Decision tree

```
Do you want to modify an existing app's behavior?
├─ YES → Use LSPosed (via Magisk + Zygisk)
└─ NO → Do you want permanent changes?
   ├─ YES → Use Magisk
   └─ NO → Use Shizuku (easiest, safest)
```

## Setup comparison

| Method | Time | Difficulty | Reversible |
|--------|------|-----------|-----------|
| Shizuku | 5 min | ★☆☆ | ✓ (instant) |
| Magisk | 15 min | ★★☆ | ✓ (flash original) |
| LSPosed | 20 min | ★★★ | ✓ (uninstall module) |
| Root | 30 min | ★★★★ | ✗ (tricky) |

See individual repos for detailed setup guides.
