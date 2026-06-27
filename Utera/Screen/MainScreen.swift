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

                    
                    Tab("Profile", systemImage: "person.fill") {
                        ProfileScreen()
                    }
                }
                .tint(Color("Primary"))
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
