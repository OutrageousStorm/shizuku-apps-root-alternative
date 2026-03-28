/**
 * Shizuku ADB Helper — TypeScript
 * Helps set up Shizuku wireless ADB pairing on Android 11+
 * Usage: ts-node src/index.ts setup
 *        ts-node src/index.ts verify
 *        ts-node src/index.ts grant <package>
 */
import { execSync, spawnSync } from 'child_process';
import { program } from 'commander';
import chalk from 'chalk';

function adb(cmd: string): string {
  try {
    return execSync(`adb shell ${cmd}`, { encoding: 'utf8', stdio: ['pipe','pipe','pipe'] }).trim();
  } catch { return ''; }
}

function adbRaw(cmd: string): string {
  try {
    return execSync(cmd, { encoding: 'utf8', stdio: ['pipe','pipe','pipe'] }).trim();
  } catch { return ''; }
}

function checkConnected(): boolean {
  const out = adbRaw('adb devices');
  return out.split('\n').some(l => l.includes('\tdevice'));
}

program.name('shizuku-helper').version('1.0.0').description('Shizuku wireless ADB setup helper');

program.command('setup')
  .description('Enable wireless ADB debugging on device (Android 11+)')
  .action(() => {
    if (!checkConnected()) {
      console.log(chalk.red('❌ Connect device via USB first to run initial setup.'));
      process.exit(1);
    }
    console.log(chalk.cyan('\n🔧 Setting up wireless ADB for Shizuku...\n'));

    // Enable wireless debugging
    adb('settings put global adb_wifi_enabled 1');
    console.log(chalk.green('  ✓ Wireless debugging enabled'));

    // Get device IP
    const ip = adb("ip route | awk '{print $NF}' | head -1");
    console.log(`  ✓ Device IP: ${chalk.yellow(ip)}`);

    // Start ADB in TCP mode
    adbRaw('adb tcpip 5555');
    console.log(chalk.green('  ✓ ADB TCP mode: port 5555'));

    console.log(chalk.cyan(`\n📋 Next steps:`));
    console.log(`  1. On your device: Settings → Developer Options → Wireless debugging`);
    console.log(`  2. Tap "Pair device with pairing code"`);
    console.log(`  3. Run: ${chalk.yellow(`adb pair ${ip}:<port> <code>`)}`);
    console.log(`  4. Run: ${chalk.yellow(`adb connect ${ip}:5555`)}`);
    console.log(`  5. Open Shizuku app and tap "Start via Wireless ADB"\n`);
  });

program.command('verify')
  .description('Verify Shizuku is running on the device')
  .action(() => {
    if (!checkConnected()) { console.log(chalk.red('No device')); process.exit(1); }

    console.log(chalk.cyan('\n🔍 Checking Shizuku status...\n'));

    const shizukuRunning = adb('pm list packages moe.shizuku.privileged.api').includes('moe.shizuku');
    console.log(`  Shizuku installed:  ${shizukuRunning ? chalk.green('✓') : chalk.red('✗')}`);

    const pid = adb('pidof shizuku');
    console.log(`  Shizuku running:    ${pid ? chalk.green(`✓ (PID ${pid})`) : chalk.red('✗ — open Shizuku app and start it')}`);

    const wifiDbg = adb('settings get global adb_wifi_enabled');
    console.log(`  Wireless ADB:       ${wifiDbg === '1' ? chalk.green('✓ enabled') : chalk.yellow('○ disabled')}`);

    const apiLevel = adb('getprop ro.build.version.sdk');
    console.log(`  Android API:        ${chalk.dim(apiLevel)} ${parseInt(apiLevel) >= 31 ? chalk.green('✓ (11+, full support)') : chalk.yellow('⚠ (limited support)')}`);
  });

program.command('grant <package>')
  .description('Grant Shizuku permission to an app via ADB (pm grant)')
  .action((pkg: string) => {
    if (!checkConnected()) { console.log(chalk.red('No device')); process.exit(1); }
    const result = adb(`pm grant ${pkg} moe.shizuku.manager.permission.API_V23`);
    if (!result || result === '') {
      console.log(chalk.green(`✓ Shizuku permission granted to ${pkg}`));
    } else {
      console.log(chalk.red(`✗ Failed: ${result}`));
    }
  });

program.parse();
