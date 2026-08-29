//
//  OnboardingScreen.swift
//  Utera
//
//  Created by Bee Wijaya on 26/06/26.
//

import SwiftData
import SwiftUI

struct OnboardingScreen: View {
    // MARK: - ViewModel
    @Environment(OnboardingViewModel.self) private var onboardingVM

    // MARK: - Props
    var cycleStorage: ICycleStorage
    var notificationStorage: INotificationStorage

    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea(.all)

            switch onboardingVM.onboardingState {
            case .getStarted:
                GetStartedScreen()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            case .cycleForm:
                CycleForm(cycleStorage: cycleStorage)
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            case .finish:
                FinishOnboard(notificationStorage: notificationStorage)
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .animation(.spring(duration: 0.1), value: onboardingVM.onboardingState)
    }
}

#Preview {
    OnboardingScreen(
        cycleStorage: CycleStorage(context: PreviewContainer.shared.mainContext),
        notificationStorage: NotificationStorage(context: PreviewContainer.shared.mainContext)
    )
    .environment(OnboardingViewModel())
}
