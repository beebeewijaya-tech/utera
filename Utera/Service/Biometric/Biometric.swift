//
//  Biometric.swift
//  Utera
//
//  Created by Bee Wijaya on 31/08/26.
//

import SwiftUI
import LocalAuthentication

protocol IBiometric {
    func checkAvailability() throws -> LABiometryType
    func authenticating() async throws -> Bool
}

class BiometricService: IBiometric {
    var error: NSError?
    
    // check if the device capable to do biometric
    func checkAvailability() throws -> LABiometryType {
        let context = LAContext()
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return .none
        }
        
        return context.biometryType
    }
    
    
    // authenticating the face id
    func authenticating() async throws -> Bool {
        let context = LAContext()
        let reason = "Please show your face"
        let result = try await context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: reason
        )
        guard result else {
            return false
        }
        
        return true
    }
}
