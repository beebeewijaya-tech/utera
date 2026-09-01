//
//  FertileWindow.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI

struct FertileWindow: View {
    // MARK: - ViewModel
    @Environment(CalendarViewModel.self) private var calendarVM
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                HStack {
                    Text("Day")
                        .font(.callout)
                        .foregroundStyle(Color("TextPrimary"))
                    
                    Text(calendarVM.date, format: .dateTime.day())
                        .font(.system(size: 44))
                        .bold()
                }
                Spacer()
                
                if calendarVM.ovulationDay != 0 {
                    Text("Fertile Window")
                        .padding()
                        .background(Color("System").opacity(0.2))
                        .foregroundStyle(Color("System"))
                        .bold()
                        .font(.caption)
                        .clipShape(Capsule())
                }
            }
            .padding(.bottom, 12)
            
            HStack {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 3))
                    .fill(Color("Prediction"))
                    .frame(width: 10, height: 10)
                
                Text("Next Fertility in: \(calendarVM.getNearestFertile()) days")
                    .font(.caption)
                    .foregroundStyle(Color("Prediction"))
            }
            .padding(.bottom, 12)
            
            HStack {
                Circle()
                    .fill(Color("System"))
                    .frame(width: 10, height: 10)
                
                if calendarVM.ovulationDay > 0 {
                    Text("Ovulation in: \(calendarVM.ovulationDay) days")
                        .font(.caption)
                        .foregroundStyle(Color("TextSecondary"))
                } else {
                    Text("Not near ovulation - safe")
                        .font(.caption)
                        .foregroundStyle(Color("TextSecondary"))
                }
            }
            .padding(.bottom, 12)
            
            if calendarVM.ovulationDay != 0 {
                HStack(alignment: .top, spacing: 16) {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .padding(12)
                        .foregroundStyle(.white)
                        .background(Color("System"))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text("High chance to conceive")
                            .font(.callout)
                            .bold()
                            .foregroundStyle(Color("System"))
                        
                        Text(calendarVM.advise)
                            .font(.caption)
                            .foregroundStyle(Color("System").opacity(0.8))
                            .italic()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color("System").opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.1), radius: 1)
    }
}
