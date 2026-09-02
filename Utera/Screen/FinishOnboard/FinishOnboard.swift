//
//  FinishOnboard.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI
import SwiftData

struct FinishOnboard: View {
    // MARK: - ViewModel
    @Environment(OnboardingViewModel.self) private var onboardingVM
    @Environment(SnackbarViewModel.self) private var snackbarVM
    @State private var notificationVM: NotificationViewModel
    
    // MARK: - Storage
    @Environment(\.modelContext) private var modelContext
    
    // MARK: - Property
    @State private var daysRemindMe: [NotificationForm] = [
        .three,
        .five,
        .seven
    ]
    
    // MARK: - Function
    func finishSetup() async {
        let res = await notificationVM.saveNotification()
        if let err = notificationVM.errors.first {
            snackbarVM.showMessage(err)
            return
        }
        
        onboardingVM.onboarding = res
    }
    
    
    // MARK: - Init
    init(notificationStorage: INotificationStorage) {
        self._notificationVM = State(initialValue: NotificationViewModel(notificationStorage: notificationStorage))
    }
    
    var body: some View {
        VStack {
            Image(systemName: "bell.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .padding()
                .background(Color("Prediction").opacity(0.1))
                .foregroundStyle(Color("Prediction"))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.bottom, 16)
            
            Text("Stay ahead of your cycle")
                .font(.title2)
                .bold()
                .foregroundStyle(Color("TextPrimary"))
                .padding(.bottom, 8)

            Text("We'll remind you before your period is predicted to start. Reminders are local nothing ever leaves your phone.")
                .font(.callout)
                .foregroundStyle(Color("TextSecondary"))
                .multilineTextAlignment(.center)
                .padding(.bottom, 24)

            VStack(alignment: .leading) {
                Text("Remind me")
                    .font(.caption)
                    .foregroundStyle(Color("TextSecondary"))
                
                HStack {
                    ForEach(daysRemindMe.indices, id: \.self) { idx in
                        let day = daysRemindMe[idx]
                        AppPill(
                            label: "\(day.label) days",
                            style: day.label == notificationVM.days ? .active : .inactive
                        ) {
                            notificationVM.days = day.label
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.bottom, 12)
            
            Spacer()
            
            AppButton(label: "Finish Setup", style: .primary) {
                Task {
                    await finishSetup()
                }
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 12)
        .snackbar()
    }
}

#Preview {
    ZStack {
        Color("Background")
            .ignoresSafeArea(.all)
        
        FinishOnboard(
            notificationStorage: NotificationStorage(context: PreviewContainer.shared.mainContext)
        )
    }
    .environment(OnboardingViewModel())
    .environment(SnackbarViewModel())
}
