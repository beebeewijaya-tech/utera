//
//  AuthenticationViewModel.swift
//  Utera
//
//  Created by Bee Wijaya on 01/09/26.
//

import SwiftUI
import LocalAuthentication

enum AuthenticationState: Equatable {
    case idle
    case loading
    case authenticated
    case error(String)
}

@Observable
class AuthenticationViewModel {
    var biometricService: IBiometric
    var authState: AuthenticationState = .idle
    var biometryType: LABiometryType = .none
    
    init(biometricService: IBiometric = BiometricService()) {
        self.biometricService = biometricService
    }
    
    func lockApp() {
        authState = .idle
    }
    
    func checkAvailable() {
        do {
            biometryType = try self.biometricService.checkAvailability()
        } catch {
            self.authState = .error(error.localizedDescription)
        }
    }
    
    func requestToAuthenticate() async {
        guard authState != .authenticated else { return }
        authState = .loading
        
        do {
            _ = try await self.biometricService.authenticating()
            self.authState = .authenticated
        } catch {
            self.authState = .error(error.localizedDescription)
        }
    }
}
