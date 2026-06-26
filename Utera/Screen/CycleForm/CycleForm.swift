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
            
            
            Spacer()
            
            
            AppButton(label: "Continue", style: .primary) {
                
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


#Preview {
    ZStack {
        Color("Background")
            .ignoresSafeArea(.all)
        
        CycleForm()
    }
}
