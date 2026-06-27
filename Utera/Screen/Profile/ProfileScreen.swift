//
//  ProfileScreen.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI
import SwiftData

struct ProfileScreen: View {
    // MARK: - Query
    @Query private var cycles: [CycleModel]
    @Query private var notifications: [NotificationModel]

    // MARK: - Environment
    @Environment(\.modelContext) private var modelContext
    @Environment(SnackbarViewModel.self) private var snackbarVM

    // MARK: - ViewModel
    @State private var profileVM = ProfileViewModel()

    private var cycle: CycleModel? { cycles.first }
    private var notification: NotificationModel? { notifications.first }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Profile")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 4)

                Text("Update your cycle information anytime.")
                    .font(.callout)
                    .foregroundStyle(Color("TextSecondary"))
                    .padding(.bottom, 20)

                AppSectionInput {
                    VStack(alignment: .leading) {
                        Text("Last period started")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(Color("TextPrimary"))
                            .padding(.bottom, 2)

                        Text("Required")
                            .font(.caption2)
                            .foregroundStyle(Color("Primary"))
                    }
                    DatePicker("", selection: Bindable(profileVM).date, displayedComponents: .date)
                }

                AppSectionInput {
                    VStack(alignment: .leading) {
                        Text("Average cycle length")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(Color("TextPrimary"))
                            .padding(.bottom, 2)

                        Text("Period to period")
                            .font(.caption2)
                            .foregroundStyle(Color("TextSecondary"))
                    }
                    Spacer()
                    AppCounter(value: Bindable(profileVM).avgCycle, label: "d")
                }

                AppSectionInput {
                    VStack(alignment: .leading) {
                        Text("Average period length")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(Color("TextPrimary"))
                            .padding(.bottom, 2)

                        Text("Days of bleeding")
                            .font(.caption2)
                            .foregroundStyle(Color("TextSecondary"))
                    }
                    Spacer()
                    AppCounter(value: Bindable(profileVM).avgPeriod, label: "d")
                }
                .padding(.bottom, 12)

                VStack(alignment: .leading) {
                    Text("Cycle regularity")
                        .font(.caption)
                        .foregroundStyle(Color("TextSecondary"))

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(profileVM.cycleRegularOptions, id: \.self) { option in
                                AppPill(label: option, style: profileVM.selectedCycleRegular == option ? .active : .inactive) {
                                    profileVM.selectedCycleRegular = option
                                }
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 4)
                    }
                }
                .padding(.bottom, 12)

                VStack(alignment: .leading) {
                    Text("Tracking goal")
                        .font(.caption)
                        .foregroundStyle(Color("TextSecondary"))

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(profileVM.trackingGoalOptions, id: \.self) { option in
                                AppPill(label: option, style: profileVM.selectedTrackingGoal == option ? .active : .inactive) {
                                    profileVM.selectedTrackingGoal = option
                                }
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 4)
                    }
                }
                .padding(.bottom, 12)

                AppSectionInput {
                    VStack(alignment: .leading) {
                        Text("Period reminder")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(Color("TextPrimary"))
                            .padding(.bottom, 2)

                        Text("Days before period starts")
                            .font(.caption2)
                            .foregroundStyle(Color("TextSecondary"))
                            .padding(.bottom, 12)
                        
                        
                        HStack(spacing: 8) {
                            ForEach(profileVM.daysOptions, id: \.self) { option in
                                AppPill(label: "\(option)d", style: profileVM.notificationDays == option ? .active : .inactive) {
                                    profileVM.notificationDays = option
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 40)

                AppButton(label: "Save Changes", style: .primary) {
                    profileVM.save(cycle: cycle, notification: notification, context: modelContext)
                    snackbarVM.showMessage("Changes saved!", type: .success)
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onAppear {
            profileVM.load(cycle: cycle, notification: notification)
        }
        .snackbar()
    }
}

#Preview {
    ZStack {
        Color("Background")
            .ignoresSafeArea(.all)

        ProfileScreen()
    }
    .environment(SnackbarViewModel())
    .modelContainer(for: [CycleModel.self, NotificationModel.self], inMemory: true)
}
