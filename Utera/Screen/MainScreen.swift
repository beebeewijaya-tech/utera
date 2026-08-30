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

    @State private var snackbarVM: SnackbarViewModel = SnackbarViewModel()
    @State private var onboardingVM = OnboardingViewModel()
    @State private var calendarVM: CalendarViewModel

    // MARK: - Propertes
    var cyclePromptStorage: ICyclePromptStorage
    var cycleStorage: ICycleStorage
    var notificationStorage: INotificationStorage
    
    // MARK: - Init
    init(
        cyclePromptStorage: ICyclePromptStorage,
        cycleStorage: ICycleStorage,
        notificationStorage: INotificationStorage
    ) {
        self.cyclePromptStorage = cyclePromptStorage
        self.cycleStorage = cycleStorage
        self.notificationStorage = notificationStorage
        
        self._calendarVM = State(initialValue: CalendarViewModel(
            cyclePromptStorage: cyclePromptStorage,
            cycleStorage: cycleStorage
        ))
    }

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
                        ProfileScreen(
                            cycleStorage: cycleStorage,
                            notificationStorage: notificationStorage
                        )
                    }
                }
                .tint(Color("Primary"))
            } else {
                OnboardingScreen(
                    cycleStorage: cycleStorage,
                    notificationStorage: notificationStorage
                )
            }
        }
        .environment(onboardingVM)
        .environment(snackbarVM)
        .environment(calendarVM)
    }
}

#Preview {
    MainScreen(
        cyclePromptStorage: CyclePromptStorage(
            context: PreviewContainer.shared.mainContext
        ),
        cycleStorage: CycleStorage(
            context: PreviewContainer.shared.mainContext
        ),
        notificationStorage: NotificationStorage(
            context: PreviewContainer.shared.mainContext
        )
    )
}
