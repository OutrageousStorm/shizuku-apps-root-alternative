# Integrate Shizuku in Your Kotlin App

Copy-paste ready Kotlin code for Shizuku API integration.

## 1. Add dependency

```gradle
dependencies {
    implementation 'dev.rikka.shizuku:api:13.1.0'
    implementation 'dev.rikka.shizuku:provider:13.1.0'
}
```

## 2. Request permission

```kotlin
// In your Activity
class MainActivity : AppCompatActivity() {
    private val shizukuPermission = registerForActivityResult(RequestPermission()) {
        if (it) {
            // Permission granted
            executeShizukuCommand()
        }
    }
    
    private fun executeShizukuCommand() {
        Shizuku.addRequestPermissionResultListener { requestCode, grantResult ->
            if (grantResult == PackageManager.PERMISSION_GRANTED) {
                val result = Shizuku.newProcess(arrayOf("pm", "list", "packages"), null, null).inputStream.bufferedReader().readText()
                Log.d("Shizuku", "Result: $result")
            }
        }
        shizukuPermission.launch(null)
    }
}
```

## 3. Execute shell commands

```kotlin
fun executeCommand(cmd: String): String {
    val process = Shizuku.newProcess(cmd.split(" ").toTypedArray(), null, null)
    return process.inputStream.bufferedReader().readText()
}

// Usage
val apps = executeCommand("pm list packages")
val battery = executeCommand("dumpsys battery")
```

## 4. Listen for Shizuku availability

```kotlin
class ShizukuActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        Shizuku.addBinderReceivedListener {
            // Shizuku is now available
            Log.d("Shizuku", "Available!")
        }
        
        Shizuku.addBinderDeadListener {
            // Shizuku is no longer available
            Log.d("Shizuku", "Disconnected")
        }
    }
}
```

## 5. App Ops via Shizuku

```kotlin
fun grantAppOp(packageName: String, op: String) {
    val cmd = arrayOf("cmd", "appops", "set", packageName, op, "allow")
    Shizuku.newProcess(cmd, null, null).waitFor()
}

fun revokeAppOp(packageName: String, op: String) {
    val cmd = arrayOf("cmd", "appops", "set", packageName, op, "deny")
    Shizuku.newProcess(cmd, null, null).waitFor()
}

// Usage
grantAppOp("com.example.app", "RECORD_AUDIO")
```

## Error handling

```kotlin
try {
    Shizuku.checkPermission()
    // Safe to use Shizuku
} catch (e: IllegalStateException) {
    Log.e("Shizuku", "Not available", e)
}
```
