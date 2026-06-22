import Foundation
import UIKit

public final class JailbreakDetector {
    
    /// Execution array of known system paths altered or added during jailbreak deployment
    private static let structuralRiskPaths = [
        "/Applications/Cydia.app",
        "/Applications/Sileo.app",
        "/usr/sbin/sshd",
        "/usr/bin/sshd",
        "/bin/bash",
        "/Library/MobileSubstrate/MobileSubstrate.dylib"
    ]
    
    /// Evaluates filesystem structure to determine security integrity
    /// - Returns: true if standard iOS sandboxing constraints are missing or bypassed
    public static func isDeviceCompromised() -> Bool {
        // Test 1: File system path checking
        for path in structuralRiskPaths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        
        // Test 2: Directory sandbox write capabilities check
        let restrictedTextPayload = "Sandbox Verification Attempt Data"
        let fallbackWritePath = "/private/jailbreak_payload_test.txt"
        
        do {
            try restrictedTextPayload.write(toFile: fallbackWritePath, atomically: true, encoding: .utf8)
            // If execution reaches this block, the application can write data anywhere on the disk root
            try FileManager.default.removeItem(atPath: fallbackWritePath)
            return true
        } catch {
            // Write operations blocked as expected inside a standard, secure sandbox
            return false
        }
    }
}
