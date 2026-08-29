//
//  MainScreen.swift
//  Utera
//
//  Created by Bee Wijaya on 26/06/26.
//

import SwiftData
import SwiftUI

struct MainScreen: View {
    // MARK: - ViewModel

    @State private var snackbarVM: SnackbarViewModel = .init()
    @State private var onboardingVM = OnboardingViewModel()

    // MARK: - Propertes

    var cyclePromptStorage: ICyclePromptStorage
    var cycleStorage: ICycleStorage

    var body: some View {
        VStack {
            if onboardingVM.onboarding {
                TabView {
                    Tab("Home", systemImage: "house.fill") {
                        HomeScreen(
                            cyclePromptStorage: cyclePromptStorage
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
                OnboardingScreen(cycleStorage: cycleStorage)
            }
        }
        .environment(onboardingVM)
        .environment(snackbarVM)
    }
}

#Preview {
    MainScreen(
        cyclePromptStorage: CyclePromptStorage(
            context: PreviewContainer.shared.mainContext
        ),
        cycleStorage: CycleStorage(
            context: PreviewContainer.shared.mainContext
        )
    )
}
