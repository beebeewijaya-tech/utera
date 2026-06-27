//
//  FertileWindow.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI

struct FertileWindow: View {
    var currentDate: Date
    var cyclePredicted: CyclePromptTask?
    
    var ovulationDay: String {
        guard let raw = cyclePredicted?.fertileWindowEnd else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let ovulationDate = formatter.date(from: raw) else { return "" }
        let today = Calendar.current.startOfDay(for: .now)
        let target = Calendar.current.startOfDay(for: ovulationDate)
        let days = Calendar.current.dateComponents([.day], from: today, to: target).day ?? 0
        
        switch days {
        case 0: return "Ovulation today"
        case 1: return "Ovulation tomorrow"
        case ..<0: return "Ovulation passed"
        default: return "Ovulation in \(days) days"
        }
    }
        
    var isInFertileWindow: Bool {
          guard let raw = cyclePredicted?.fertileWindowStart,
                let rawEnd = cyclePredicted?.fertileWindowEnd else { return false }

          let formatter = DateFormatter()
          formatter.dateFormat = "yyyy-MM-dd"

          guard let start = formatter.date(from: raw),
                let end = formatter.date(from: rawEnd) else { return false }

          let today = Calendar.current.startOfDay(for: .now)
          return today >= Calendar.current.startOfDay(for: start) &&
                 today <= Calendar.current.startOfDay(for: end)
      }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                HStack {
                    Text("Day")
                        .font(.callout)
                        .foregroundStyle(Color("TextPrimary"))
                    
                    Text(currentDate, format: .dateTime.day())
                        .font(.system(size: 44))
                        .bold()
                }
                Spacer()
                
                if isInFertileWindow {
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
                    .fill(Color("System"))
                    .frame(width: 10, height: 10)
                Text(ovulationDay)
                    .font(.default)
                    .foregroundStyle(Color("TextSecondary"))
            }
            .padding(.bottom, 12)
            
            if isInFertileWindow {
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
                        
                        Text(cyclePredicted?.advise ?? "")
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
