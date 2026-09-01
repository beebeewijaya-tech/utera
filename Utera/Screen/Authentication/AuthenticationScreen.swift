//
//  AuthenticationScreen.swift
//  Utera
//
//  Created by Bee Wijaya on 01/09/26.
//

import SwiftUI


struct AuthenticationScreen: View {
    @Environment(AuthenticationViewModel.self) private var authVM
    
    var body: some View {
        VStack {
            if authVM.authState != .authenticated {
                ProgressView()
            }
        }
        .task {
            authVM.checkAvailable()
            await authVM.requestToAuthenticate()
        }
        .onChange(of: authVM.authState) { old, new in
            if old != new, case let .error(error) = new {
                print(error)
            }
        }
    }
}


