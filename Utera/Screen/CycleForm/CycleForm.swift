//
//  CycleForm.swift
//  Utera
//
//  Created by Bee Wijaya on 26/06/26.
//

import SwiftUI

struct Pill: Identifiable {
    var id: UUID = UUID()
    var label: String
}

struct CycleForm: View {
    // MARK: - ViewModel
    @Environment(OnboardingViewModel.self) private var onboardingVM
    @Environment(SnackbarViewModel.self) private var snackbarVM
    @State private var cycleFormVM = CycleFormViewModel()
    
    // MARK: - Property
    @State private var cycleRegular: [Pill] = [
        Pill(label: "Pretty regular"),
        Pill(label: "Varies a lot"),
        Pill(label: "Not sure")
    ]
    @State private var trackingGoal: [Pill] = [
        Pill(label: "General tracking"),
        Pill(label: "Trying to conceive"),
        Pill(label: "Avoiding pregnancy")
    ]

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
                                let p = cycleRegular[idx]
                                AppPill(label: p.label, style: cycleFormVM.cycleRegular == p.label ? .active : .inactive) {
                                    cycleFormVM.cycleRegular = p.label
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
                                let p = trackingGoal[idx]
                                AppPill(label: p.label, style: cycleFormVM.trackingGoal == p.label ? .active : .inactive) {
                                    cycleFormVM.trackingGoal = p.label
                                }
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 4)
                    }
                }
                .padding(.bottom, 40)

                
                AppButton(label: "Continue", style: .primary) {
                    cycleFormVM.submit()
                    
                    if let err = cycleFormVM.errors.first {
                        snackbarVM.showMessage(err)
                        return
                    }
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
        
        CycleForm()
    }
    .environment(OnboardingViewModel())
    .environment(SnackbarViewModel())
}
