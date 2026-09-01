//
//  MainScreen.swift
//  Utera
//
//  Created by Bee Wijaya on 26/06/26.
//

import SwiftData
import SwiftUI

struct MainScreen: View {
    @Environment(\.scenePhase) private var scenePhase

    // MARK: - ViewModel

    @State private var snackbarVM: SnackbarViewModel = SnackbarViewModel()
    @State private var onboardingVM = OnboardingViewModel()
    @State private var calendarVM: CalendarViewModel
    @State private var authVM = AuthenticationViewModel()

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
            if authVM.authState != .authenticated {
                AuthenticationScreen()
            } else if onboardingVM.onboarding {
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
        .environment(authVM)
        .onChange(of: scenePhase) { _, newValue in
            switch newValue {
            case .background:
                authVM.lockApp()
            case .active:
                Task { await authVM.requestToAuthenticate() }
            default:
                return
            }
        }
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
