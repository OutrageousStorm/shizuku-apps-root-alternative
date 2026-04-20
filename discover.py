#!/usr/bin/env python3
"""
discover.py -- Discover what Shizuku-enabled apps you can use
Lists installed apps that support Shizuku, shows capability matrix.
Usage: python3 discover.py
"""
import subprocess

SHIZUKU_APPS = {
    'App Manager': 'com.android.apt',
    'Hail': 'com.aistra.hail',
    'Waver': 'com.gmd.hidesoftkeys',
    'NetGuard': 'eu.faircode.netguard',
    'Tasker': 'net.dinglisch.android.taskerm',
    'Brevent': 'me.piebridge.brevent',
    'Island': 'com.oasisfeng.island',
}

def adb(cmd):
    r = subprocess.run(f"adb shell {cmd}", shell=True, capture_output=True, text=True)
    return r.stdout.strip()

def get_installed():
    out = adb("pm list packages")
    return {l.split(":")[1] for l in out.splitlines() if l.startswith("package:")}

def main():
    installed = get_installed()
    print("\n🎯 Shizuku App Discovery\n")
    print("Installed Shizuku-compatible apps:")
    count = 0
    for name, pkg in SHIZUKU_APPS.items():
        if pkg in installed:
            print(f"  ✓ {name:<20} ({pkg})")
            count += 1
    if count == 0:
        print("  (none)")
    print(f"\nFound: {count}/{len(SHIZUKU_APPS)} available apps")
    print("\nTo use Shizuku:")
    print("  1. Install Shizuku app (F-Droid or GitHub)")
    print("  2. Enable Developer Options → Wireless debugging")
    print("  3. Grant permission when prompted in each app")

if __name__ == "__main__":
    main()
