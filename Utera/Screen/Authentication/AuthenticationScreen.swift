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
            switch authVM.authState {
            case .idle:
                AppLottie(animation: "unlock")
                    .frame(width: 100, height: 100)
                Text("Please authenticate to continue")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(Color("Primary"))
            case .error(let err):
                AppLottie(animation: "close")
                    .frame(width: 100, height: 100)
                
                Text("Getting error: \(err)")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(Color("Primary"))
            default:
                AppLottie(animation: "loading")
                    .frame(width: 100, height: 100)
                
                Text("Loading...")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(Color("Primary"))
            }
            
            Button {
                authVM.checkAvailable()
                Task { await authVM.requestToAuthenticate() }
            } label: {
                VStack {
                    Text("Authenticate")
                        .foregroundStyle(.white)
                        .font(.default)
                        .bold()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 58)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .background(Color("Primary"))
            }
            .padding(.top, 12)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .onChange(of: authVM.authState) { old, new in
            if old != new, case let .error(error) = new {
                print(error)
            }
        }
    }
}


