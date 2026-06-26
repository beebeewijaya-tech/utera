//
//  CycleForm.swift
//  Utera
//
//  Created by Bee Wijaya on 26/06/26.
//

import SwiftUI


struct CycleForm: View {
    // MARK: - State
    @State var date = Date()
    @State var avgCycle: Int = 0
    @State var avgPeriod: Int = 0

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
                    
                    DatePicker("", selection: $date, displayedComponents: .date)
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
                    AppCounter(value: $avgCycle, label: "d")
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
                    AppCounter(value: $avgPeriod, label: "d")
                }
                .padding(.bottom, 12)
                
                VStack(alignment: .leading) {
                    Text("Cycle regularity")
                        .font(.caption)
                        .foregroundStyle(Color("TextSecondary"))
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            AppPill(label: "Pretty Regular", style: .inactive) {
                                
                            }
                            
                            AppPill(label: "Varies a lot", style: .inactive) {
                                
                            }
                            
                            AppPill(label: "Not sure", style: .inactive) {
                                
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
                            AppPill(label: "General Tracking", style: .inactive) {
                                
                            }
                            
                            AppPill(label: "Trying to conceive", style: .inactive) {
                                
                            }
                            
                            AppPill(label: "Avoiding pregnancy", style: .inactive) {
                                
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 4)
                    }
                }
                .padding(.bottom, 40)

                
                AppButton(label: "Continue", style: .primary) {
                    
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}


#Preview {
    ZStack {
        Color("Background")
            .ignoresSafeArea(.all)
        
        CycleForm()
    }
}
