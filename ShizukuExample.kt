// ShizukuExample.kt - Sample Kotlin/Android app using Shizuku
// Build with: ./gradlew assembleDebug

package com.example.shizukudemo

import android.os.RemoteException
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import rikka.shizuku.Shizuku

class ShizukuDemoActivity : AppCompatActivity() {
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        
        val statusText: TextView = findViewById(R.id.status_text)
        val execButton: Button = findViewById(R.id.exec_button)
        val listAppsButton: Button = findViewById(R.id.list_apps_button)
        
        // Check Shizuku availability
        updateStatus(statusText)
        
        execButton.setOnClickListener {
            try {
                val result = runShellCommand("getprop ro.product.model")
                statusText.text = "Device: $result"
            } catch (e: Exception) {
                statusText.text = "Error: ${e.message}"
            }
        }
        
        listAppsButton.setOnClickListener {
            try {
                val result = runShellCommand("pm list packages | wc -l")
                statusText.text = "Total packages: $result"
            } catch (e: Exception) {
                statusText.text = "Error: ${e.message}"
            }
        }
    }
    
    private fun updateStatus(view: TextView) {
        val available = Shizuku.isAvailable()
        val granted = try {
            Shizuku.checkSelfPermission() == 0
        } catch (e: Exception) {
            false
        }
        view.text = when {
            !available -> "Shizuku not installed"
            !granted -> "Shizuku permission needed"
            else -> "✓ Shizuku ready"
        }
    }
    
    private fun runShellCommand(cmd: String): String {
        return Shizuku.newProcess(
            arrayOf("sh", "-c", cmd),
            null,
            null
        ).inputStream.bufferedReader().readText().trim()
    }
}
