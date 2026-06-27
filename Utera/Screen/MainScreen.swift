//
//  MainScreen.swift
//  Utera
//
//  Created by Bee Wijaya on 26/06/26.
//

import SwiftUI


struct MainScreen: View {
    // MARK: - ViewModel
    @State private var snackbarVM: SnackbarViewModel = SnackbarViewModel()
    @State private var onboardingVM = OnboardingViewModel()

    var body: some View {
        VStack {
            if onboardingVM.onboarding {
                TabView {
                    Tab("1", systemImage: "house.fill") {
                        
                    }
                    
                    Tab("1", systemImage: "calendar") {
                        
                    }

                    
                    Tab("1", systemImage: "person.fill") {
                        
                    }
                }
            } else {
                OnboardingScreen()
            }
        }
        .environment(onboardingVM)
        .environment(snackbarVM)
    }
}


#Preview {
    MainScreen()
}
