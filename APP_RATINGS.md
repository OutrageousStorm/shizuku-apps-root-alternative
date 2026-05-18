# Shizuku App Ratings & Comparison

Comprehensive ratings of the best Shizuku-based apps across categories.

## System Tools

### **Wi-Fi ADB** ⭐⭐⭐⭐⭐
- ADB over TCP without cable
- Rock solid, minimal overhead
- Official app by Android team

### **App Manager** ⭐⭐⭐⭐⭐
- Full package manager interface
- Can backup/restore individual APKs
- Permission management
- Works as root alternative

### **Swift Backup** ⭐⭐⭐⭐
- Full app backup (data + APK)
- Selective restore
- Scheduling
- ADB + Shizuku support

### **Keyboard Switcher** ⭐⭐⭐⭐
- Switch keyboards without touching Settings
- Minimal, efficient
- Works with Shizuku

## Telecom

### **CallRecorder** ⭐⭐⭐⭐
- Record calls with Shizuku elevation
- Works on most Android 11+
- Better than ALSA recording

### **Truecaller** ⭐⭐⭐
- Spam blocking via Shizuku
- Ad-heavy but functional
- Proprietary algorithm

## Battery

### **BetterBattery** ⭐⭐⭐⭐
- Advanced Doze control via Shizuku
- Real impact on standby time
- Good UI

### **AccuBattery** ⭐⭐⭐
- Battery health monitoring
- Estimates degradation
- Limited Shizuku features

## Security

### **Permission Master** ⭐⭐⭐⭐⭐
- Grant dangerous permissions without system toggle
- Fine-grained control
- Pairs well with XPrivacyLua

### **Should I Answer?** ⭐⭐⭐⭐
- Call filtering via Shizuku API
- Rules-based blocking
- Works offline

## Automation

### **Tasker** ⭐⭐⭐⭐⭐
- Industry standard automation
- Native Shizuku integration
- Extremely powerful

### **MacroDroid** ⭐⭐⭐⭐
- Easier than Tasker
- Good Shizuku support
- Predefined triggers/actions

## Overall recommendations

| Use case | Recommended |
|----------|-------------|
| Backup & restore | App Manager + Swift Backup |
| Permission control | Permission Master + XPrivacyLua |
| Battery optimization | BetterBattery + Universal GMS Doze |
| Call blocking | Should I Answer |
| Full automation | Tasker |

## What NOT to use Shizuku for

❌ **Better performance** — Shizuku elevation ≠ root speed
❌ **Remove system apps** — Use `pm uninstall -k --user 0`
❌ **Modify system files** — Still not possible, use Magisk
❌ **Full root access** — Shizuku is intentionally restricted

Use Magisk/KernelSU if you need those.
