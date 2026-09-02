//
//  CycleForm.swift
//  Utera
//
//  Created by Bee Wijaya on 26/06/26.
//

import SwiftData
import SwiftUI

struct CycleForm: View {
    // MARK: - ViewModel

    @Environment(OnboardingViewModel.self) private var onboardingVM
    @Environment(SnackbarViewModel.self) private var snackbarVM
    @State private var cycleFormVM: CycleFormViewModel

    // MARK: - Property

    @State private var cycleRegular: [CycleConditionForm] = [
        CycleConditionForm.regular,
        CycleConditionForm.varies,
        CycleConditionForm.notsure
    ]
    @State private var trackingGoal: [TrackingGoalForm] = [
        .general,
        .tryconceive,
        .avoid
    ]

    // MARK: - Model

    @Environment(\.modelContext) private var modelContext

    // MARK: - Function

    func submitForm() {
        let res = cycleFormVM.submit()

        if let err = cycleFormVM.errors.first {
            snackbarVM.showMessage(err)
            return
        }

        if res {
            onboardingVM.setState(.finish)
        }
    }

    // MARK: - Init

    init(cycleStorage: ICycleStorage) {
        _cycleFormVM = State(initialValue: CycleFormViewModel(cycleStorage: cycleStorage))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("A few cycle basics")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 8)

                Text("This sets your starting predictions. You can change everything later.")
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

                    DatePicker("", selection: $cycleFormVM.date, displayedComponents: .date)
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
                    AppCounter(value: $cycleFormVM.avgCycle, label: "d")
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
                    AppCounter(value: $cycleFormVM.avgPeriod, label: "d")
                }
                .padding(.bottom, 12)

                VStack(alignment: .leading) {
                    Text("Cycle regularity")
                        .font(.caption)
                        .foregroundStyle(Color("TextSecondary"))

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(cycleRegular.indices, id: \.self) { idx in
                                let goal = cycleRegular[idx]
                                AppPill(
                                    label: goal.label,
                                    style: cycleFormVM.cycleRegular == goal.label ? .active : .inactive
                                ) {
                                    cycleFormVM.cycleRegular = goal.label
                                }
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 4)
                    }
                }
                .padding(.bottom, 12)

                VStack(alignment: .leading) {
                    Text("Tracking Goal")
                        .font(.caption)
                        .foregroundStyle(Color("TextSecondary"))

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(trackingGoal.indices, id: \.self) { idx in
                                let goal = trackingGoal[idx]
                                AppPill(
                                    label: goal.label,
                                    style: cycleFormVM.trackingGoal == goal.label ? .active : .inactive
                                ) {
                                    cycleFormVM.trackingGoal = goal.label
                                }
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 4)
                    }
                }
                .padding(.bottom, 40)

                AppButton(label: "Continue", style: .primary) {
                    submitForm()
                }
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .snackbar()
    }
}

#Preview {
    ZStack {
        Color("Background")
            .ignoresSafeArea(.all)

        CycleForm(
            cycleStorage: CycleStorage(context: PreviewContainer.shared.mainContext)
        )
    }
    .environment(OnboardingViewModel())
    .environment(SnackbarViewModel())
}
