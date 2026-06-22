#!/usr/bin/env kotlin
@file:Repository("https://maven.org")
@file:DependsOn("com.squareup.okhttp3:okhttp:4.12.0")

import okhttp3.OkHttpClient
import okhttp3.Request
import java.io.File
import java.io.IOException

fun main() {
    val client = OkHttpClient()
    val targetUrl = "https://theapplewiki.com" 
    val request = Request.Builder().url(targetUrl).build()

    println("Connecting to Apple Wiki API API...")

    try {
        client.newCall(request).execute().use { response ->
            if (!response.isSuccessful) throw IOException("Server returned error code: ${response.code}")
            
            val bodyText = response.body?.string() ?: ""
            val outputFile = File("ios_firmware_manifest.json")
            outputFile.writeText(bodyText)
            
            println("Download complete. Saved manifest to: ${outputFile.absolutePath}")
            println("File size: ${outputFile.length()} bytes")
        }
    } catch (e: Exception) {
        System.err.println("Network request failed: ${e.message}")
    }
}
