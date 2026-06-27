//
//  GetStartedScreen.swift
//  Utera
//
//  Created by Bee Wijaya on 26/06/26.
//

import SwiftUI

struct GetStartedScreen: View {
    // MARK: - ViewModel
    @Environment(OnboardingViewModel.self) private var onboardingVM
    
    
    var body: some View {
        VStack {
            Spacer()
            Image("utera-logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            Text("U T E R A")
                .font(.title)
                .bold()
                .padding(.bottom, 12)
            
            
            Text("Understand your cycle quietly, accurately, and entirely on your own device.")
                .font(.callout)
                .foregroundStyle(Color("TextSecondary"))
                .multilineTextAlignment(.center)
            
            Spacer()
            
            HStack {
                Image(systemName: "lock.heart")
                    .foregroundStyle(Color("TextSecondary"))

                Text("All your data stays on this iPhone")
                    .foregroundStyle(Color("TextSecondary"))
                    .font(.caption)
            }
            .padding(.bottom, 8)
            
            AppButton(label: "Get Started", style: .primary) {
                onboardingVM.onboardingState = .cycleForm
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 12)
    }
}


#Preview {
    ZStack {
        Color("Background")
            .ignoresSafeArea(.all)
        
        GetStartedScreen()
    }
    .environment(OnboardingViewModel())
}
