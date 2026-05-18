# Shizuku vs Root: Comprehensive Comparison

When to use Shizuku, when to use root, and how they compare.

## Feature comparison

| Feature | Shizuku | Magisk | Notes |
|---------|---------|--------|-------|
| **Installation** | One-click via app + adb | Flash in recovery | Root is more invasive |
| **OTA updates** | Survives OTA | Need to re-patch boot.img | Shizuku is transparent to OS |
| **App detection** | Apps can't detect | Apps can detect (hide with module) | Shizuku wins for stealth |
| **System modifications** | Limited (adb-equivalent) | Full kernel/system access | Root is more powerful |
| **Permission revocation** | Via appops + settings | Via Magisk hide/DenyList | Both effective |
| **Background execution** | Limited (service-based) | Full background access | Root allows deeper hooks |
| **Persistence** | Survives reboots | Survives reboots | Both persist |
| **SafetyNet/Play Integrity** | Passes (no detection) | Fails (must use spoofing) | Shizuku is better for banking |
| **Xposed/LSPosed** | Not compatible | Compatible via Zygisk | Root needed for LSPosed |
| **Custom recovery** | Not needed | TWRP required | Shizuku requires only ADB |

## When to use Shizuku

✅ **Best for:**
- Banks, payment apps (they detect root)
- One-time permission grants (e.g., revoke location once)
- System tweaks without root signature
- Testing (no system modifications)

```bash
# Typical Shizuku use cases
Shizuku + SetEdit → tweak hidden system settings
Shizuku + AppOps → revoke permissions per-app
Shizuku + Canta → freeze/hide apps without root
```

## When to use Root (Magisk)

✅ **Best for:**
- Custom ROMs (need system modifications)
- Xposed/LSPosed modules (deep system hooks)
- SELinux policy changes
- Hiding root with Zygisk modules
- Development/reverse engineering

```bash
# Typical root use cases
Magisk + Zygisk + DenyList → hide root from banking apps
Magisk + LSPosed → system-wide method hooks
Magisk + custom kernel → override hardware behavior
```

## Hybrid approach (best of both)

Install **both** for maximum flexibility:

1. **Magisk root** for system modifications, Xposed, custom kernels
2. **Zygisk + DenyList** to hide root from banking/sensitive apps
3. **Shizuku** running alongside for permission grants on DenyListed apps
4. **PlayIntegrityFix + TrickyStore** modules to spoof hardware attestation

```
Banking apps (DenyList + Shizuku)
├─ Magisk hidden
├─ Shizuku active
└─ Passes integrity checks

Custom ROM environment (full root)
├─ Magisk visible
├─ LSPosed active
└─ System fully modified
```

## Detection evasion

### Apps that detect root

```
com.google.android.gms (Google Play Services)
com.android.chrome (Chrome)
com.facebook.katana (Facebook)
com.twitter.android (Twitter/X)
com.banking.* (Most banking apps)
com.paypal.* (PayPal)
```

### How to hide

| Method | Evasion | Downside |
|--------|---------|----------|
| **Shizuku alone** | Perfect (no root) | Limited to adb-equivalent |
| **Magisk Hide** | Deprecated, unreliable | Doesn't work on modern devices |
| **Zygisk + DenyList** | Modern, reliable | Only hides root, not other mods |
| **TrickyStore** | Fools SafetyNet/Play Integrity | Doesn't hide APK modifications |
| **Apk-mitm patching** | Modifies app directly | Each app needs separate patch |
| **Frida hooking** | Real-time app modification | Requires frida-server |

## Performance comparison

```
                        CPU    Memory   Battery
Shizuku alone            ✓✓✓    ✓✓✓     ✓✓✓   (minimal overhead)
Magisk only              ✓✓     ✓✓      ✓✓    (small overhead)
Magisk + LSPosed         ✓      ✓       ✓     (modest overhead from modules)
Root + 5+ modules        ✗      ✗       ✗     (noticeable impact)
```

## Decision flowchart

```
├─ Need to hide from banking apps?
│  ├─ Yes → Magisk + Zygisk + DenyList + TrickyStore
│  └─ No  → Go to next
├─ Need Xposed/LSPosed modules?
│  ├─ Yes → Magisk root
│  └─ No  → Shizuku alone
├─ Need custom ROM/kernel?
│  ├─ Yes → Magisk root
│  └─ No  → Shizuku + root hybrid (both)
└─ Unsure? → Shizuku first, root later if needed
```

---

**Related:** TROUBLESHOOTING_FLOWCHART.md, TOP_APPS.md
