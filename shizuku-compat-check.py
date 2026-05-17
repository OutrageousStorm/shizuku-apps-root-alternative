#!/usr/bin/env python3
"""
shizuku-compat-check.py -- Check app compatibility with Shizuku
Usage: python3 shizuku-compat-check.py <package.name>
"""
import subprocess, sys

def adb(cmd):
    r = subprocess.run(f"adb shell {cmd}", shell=True, capture_output=True, text=True)
    return r.stdout.strip()

def check_app(pkg):
    print(f"\nShizuku Compatibility: {pkg}\n")
    
    if not adb(f"pm list packages {pkg}"):
        print("App not installed")
        return
    
    has_shizuku = bool(adb("pm list packages moe.shizuku"))
    print(f"  Shizuku installed: {'Yes' if has_shizuku else 'No'}")
    
    shizuku_pid = adb("pidof shizuku")
    print(f"  Shizuku running: {'Yes' if shizuku_pid else 'No (open Shizuku app)'}")
    
    manifest = adb(f"dumpsys package {pkg}")
    uses_shizuku = "moe.shizuku" in manifest
    print(f"  Uses Shizuku: {'Yes' if uses_shizuku else 'No'}")
    
    api = int(adb("getprop ro.build.version.sdk"))
    print(f"  Android: {api} (API {api})")
    
    has_service = "service" in manifest.lower()
    print(f"  Has services: {'Yes' if has_service else 'No'}")
    
    print()

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <package.name>")
        sys.exit(1)
    check_app(sys.argv[1])
