// ShizukuHelper.kt -- Shizuku permission and binder management
// Add to your Android app's build.gradle: implementation("dev.rikka.shizuku:api:13.0.0")

package com.example.shizukuhelper

import android.content.Context
import rikka.shizuku.Shizuku
import rikka.shizuku.ShizukuProvider
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class ShizukuHelper(private val context: Context) {
    
    /**
     * Check if Shizuku is installed and listening
     */
    fun isShizukuAvailable(): Boolean {
        return try {
            Shizuku.pingBinder()
            true
        } catch (e: Exception) {
            false
        }
    }
    
    /**
     * Request Shizuku permission from user
     * Returns true if permission granted
     */
    suspend fun requestShizukuPermission(): Boolean = withContext(Dispatchers.Main) {
        return@withContext try {
            if (Shizuku.getUid() != 0) {
                Shizuku.requestPermission(0)
            }
            Shizuku.getUid() == 0
        } catch (e: Exception) {
            false
        }
    }
    
    /**
     * Execute shell command via Shizuku
     * Requires permission already granted
     */
    suspend fun executeShellCommand(cmd: String): String = withContext(Dispatchers.Default) {
        return@withContext try {
            val process = Shizuku.newProcess(arrayOf("sh", "-c", cmd), null, null)
            process.inputStream.bufferedReader().readText()
        } catch (e: Exception) {
            "Error: ${e.message}"
        }
    }
    
    /**
     * Grant app permission via shell (e.g., WRITE_SECURE_SETTINGS)
     */
    suspend fun grantPermission(packageName: String, permission: String): Boolean {
        return try {
            executeShellCommand("pm grant $packageName $permission")
            true
        } catch (e: Exception) {
            false
        }
    }
    
    /**
     * Modify secure setting (equivalent to: settings put secure key value)
     */
    suspend fun putSecureSetting(key: String, value: String): Boolean {
        return try {
            executeShellCommand("settings put secure $key $value")
            true
        } catch (e: Exception) {
            false
        }
    }
    
    /**
     * Get secure setting value
     */
    suspend fun getSecureSetting(key: String): String {
        return try {
            executeShellCommand("settings get secure $key").trim()
        } catch (e: Exception) {
            ""
        }
    }
    
    /**
     * Revoke app permission
     */
    suspend fun revokePermission(packageName: String, permission: String): Boolean {
        return try {
            executeShellCommand("pm revoke $packageName $permission")
            true
        } catch (e: Exception) {
            false
        }
    }
    
    /**
     * Get system property
     */
    suspend fun getSystemProperty(property: String): String {
        return try {
            executeShellCommand("getprop $property").trim()
        } catch (e: Exception) {
            ""
        }
    }
    
    /**
     * Check if device is rooted (via su binary)
     */
    suspend fun isDeviceRooted(): Boolean {
        return try {
            executeShellCommand("which su").trim().isNotEmpty()
        } catch (e: Exception) {
            false
        }
    }
}

// Usage in Activity:
// val helper = ShizukuHelper(this)
// if (helper.isShizukuAvailable()) {
//     val granted = helper.requestShizukuPermission()
//     if (granted) {
//         val result = helper.executeShellCommand("dumpsys package")
//         Log.d("Shizuku", result)
//     }
// }
