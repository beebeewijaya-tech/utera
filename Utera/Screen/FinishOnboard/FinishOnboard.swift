//
//  FinishOnboard.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI


struct FinishOnboard: View {
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
                    AppPill(label: "3 days", style: .inactive) {
                        
                    }
                    
                    AppPill(label: "5 days", style: .inactive) {
                        
                    }
                    
                    AppPill(label: "7 days", style: .inactive) {
                        
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.bottom, 12)
            
            Spacer()
            
            AppButton(label: "Finish Setup", style: .primary) {
                
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 12)
    }
}


#Preview {
    ZStack {
        Color("Background")
            .ignoresSafeArea(.all)
        
        FinishOnboard()
    }
}

