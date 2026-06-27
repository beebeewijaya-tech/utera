//
//  Onboarding.swift
//  Utera
//
//  Created by Bee Wijaya on 26/06/26.
//

import SwiftUI

struct OnboardingScreen: View {
    @State private var onboardingVM = OnboardingViewModel()

    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea(.all)
            
            switch onboardingVM.onboardingState {
            case .getStarted:
                GetStartedScreen()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            case .cycleForm:
                CycleForm()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            case .finish:
                FinishOnboard()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .animation(.spring(duration: 0.1), value: onboardingVM.onboardingState)
        .environment(onboardingVM)
    }
}

#Preview {
    OnboardingScreen()
}
