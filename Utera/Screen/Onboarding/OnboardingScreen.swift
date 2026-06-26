//
//  Onboarding.swift
//  Utera
//
//  Created by Bee Wijaya on 26/06/26.
//

import SwiftUI

enum OnboardingState {
    case getStarted, cycleForm, finish
    
    @ViewBuilder
    func screen() -> some View {
        switch self {
        case .getStarted:
            GetStartedScreen()
        case .cycleForm:
            EmptyView()
        case .finish:
            EmptyView()
        }
    }
}

struct OnboardingScreen: View {
    @State private var pageState: OnboardingState = .getStarted
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea(.all)
            
            pageState.screen()
        }
    }
}

#Preview {
    OnboardingScreen()
}
