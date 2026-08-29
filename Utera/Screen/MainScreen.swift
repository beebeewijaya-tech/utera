//
//  MainScreen.swift
//  Utera
//
//  Created by Bee Wijaya on 26/06/26.
//

import SwiftUI
import SwiftData

struct MainScreen: View {
    // MARK: - ViewModel
    @State private var snackbarVM: SnackbarViewModel = SnackbarViewModel()
    @State private var onboardingVM = OnboardingViewModel()
    
    // MARK: - Propertes
    var cycleStorage: ICycleStorage

    var body: some View {
        VStack {
            if onboardingVM.onboarding {
                TabView {
                    Tab("Home", systemImage: "house.fill") {
                        HomeScreen(
                            cycleStorage: cycleStorage,
                        )
                    }
                    
                    Tab("Calendar", systemImage: "calendar") {
                        CalendarScreen()
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
    MainScreen(
        cycleStorage: CycleStorage(context: PreviewContainer.shared.mainContext)
    )
}
