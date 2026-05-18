package main

import (
	"fmt"
	"os/exec"
	"regexp"
	"strings"
)

// ShizukuChecker verifies Shizuku compatibility on Android device
type ShizukuChecker struct {
	Device string
}

func (s *ShizukuChecker) adb(cmd string) string {
	out, _ := exec.Command("adb", "shell", cmd).Output()
	return strings.TrimSpace(string(out))
}

func (s *ShizukuChecker) CheckShizukuInstalled() bool {
	pm := s.adb("pm list packages | grep -i shizuku")
	return pm != ""
}

func (s *ShizukuChecker) CheckAPI() (int, error) {
	api := s.adb("getprop ro.build.version.sdk")
	var apiLevel int
	fmt.Sscanf(api, "%d", &apiLevel)
	return apiLevel, nil
}

func (s *ShizukuChecker) CheckKernelSupport() bool {
	// Shizuku needs KernelSU or Magisk for binder elevation
	magisk := s.adb("test -d /data/adb/magisk && echo 1 || echo 0")
	kernelsu := s.adb("test -f /proc/sys/kernel/ksu_version && echo 1 || echo 0")
	return magisk == "1" || kernelsu == "1"
}

func (s *ShizukuChecker) CheckCompatibleApps() []string {
	// Apps known to work with Shizuku
	apps := []string{
		"com.omarea.greenify",
		"com.omarea.vtools",
		"com.catch.thebeavercatch.setEdit",
		"com.playerfq.filemanager",
	}

	var compatible []string
	for _, app := range apps {
		pm := s.adb(fmt.Sprintf("pm list packages | grep %s", app))
		if pm != "" {
			compatible = append(compatible, app)
		}
	}
	return compatible
}

func (s *ShizukuChecker) PrintReport() {
	fmt.Println("
🔍 Shizuku Compatibility Report")
	fmt.Println("═══════════════════════════════════════════")

	if s.CheckShizukuInstalled() {
		fmt.Println("✅ Shizuku Manager installed")
	} else {
		fmt.Println("❌ Shizuku Manager NOT installed")
		fmt.Println("   Install from: https://github.com/RikkaApps/Shizuku/releases")
	}

	api, _ := s.CheckAPI()
	fmt.Printf("📱 Android API: %d
", api)
	if api < 27 {
		fmt.Println("⚠️  API 27+ required for Shizuku")
	}

	if s.CheckKernelSupport() {
		fmt.Println("✅ Root method (Magisk/KernelSU) detected")
	} else {
		fmt.Println("❌ No root method. Install Magisk or KernelSU first")
	}

	apps := s.CheckCompatibleApps()
	fmt.Printf("📦 Compatible apps installed: %d
", len(apps))
	for _, app := range apps {
		fmt.Printf("   • %s
", app)
	}

	fmt.Println()
}

func main() {
	checker := &ShizukuChecker{}
	checker.PrintReport()
}
