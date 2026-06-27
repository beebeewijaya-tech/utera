//
//  WeeklyCalendar.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI

enum WeeklyCellStyle {
    case active, inactive, ovulation, period
    
    
    var background: Color {
        switch self {
        case .active:
            return .white
            
        case .inactive:
            return .clear
            
        case .ovulation:
            return Color("System")
            
        case .period:
            return Color("Primary")
        }
    }
    
    var foreground: Color {
        switch self {
        case .active:
            return Color("Primary")
            
        case .inactive:
            return Color("TextPrimary")
            
        case .ovulation, .period:
            return .white
        }
    }
    
    var lineWidth: CGFloat {
        switch self {
        case .active:
            return 2
            
        case .inactive, .ovulation, .period:
            return 0
        }
    }
}

struct WeeklyCalendar: View {
    var cyclePredicted: CyclePromptTask?
    
    // MARK: - Property
    let weekLetters = ["M", "T", "W", "T", "F", "S", "S"]
    var weekDates: [Date] {
        let weekday = Calendar.current.component(.weekday, from: Date.now)
        let daysFromMonday = (weekday + 5) % 7
        let monday = Calendar.current.date(byAdding: .day, value: -daysFromMonday, to: Date.now)!
        
        return (0..<7).map {
            Calendar.current.date(byAdding: .day, value: $0, to: monday)!
        }
    }
    
    var indicators: [Date: WeeklyCellStyle] {
        var result: [Date: WeeklyCellStyle] = [:]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let predicted = cyclePredicted,
              let start = formatter.date(from: predicted.fertileWindowStart),
              let end = formatter.date(from: predicted.fertileWindowEnd),
              let nextPeriod = formatter.date(from: predicted.nextPeriodDate)
        else { return result }
        
        // Mark entire fertile window
        let days = Calendar.current.dateComponents([.day], from: start, to: end).day ?? 0
        for offset in 0...days {
            if let day = Calendar.current.date(byAdding: .day, value: offset, to: start) {
                result[Calendar.current.startOfDay(for: day)] = .ovulation
            }
        }
        
        // Override last day as ovulation peak
        result[Calendar.current.startOfDay(for: end)] = .ovulation
        
        // Next period
        result[Calendar.current.startOfDay(for: nextPeriod)] = .period
        
        return result
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Array(weekDates.enumerated()), id: \.offset) { id, d in
                    let dayNumber = Calendar.current.component(.day, from: d)
                    let isToday = Calendar.current.isDateInToday(d)
                    let key = Calendar.current.startOfDay(for: d)
                    let style: WeeklyCellStyle = isToday ? .active : (indicators[key] ?? .inactive)
                    
                    WeeklyCell(label: weekLetters[id], date: "\(dayNumber)", style: style)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}


struct WeeklyCell: View {
    var label: String
    var date: String
    var style: WeeklyCellStyle
    
    var body: some View {
        VStack {
            Text(label)
                .font(.caption2)
                .foregroundStyle(Color("TextSecondary"))
            
            Text(date)
                .padding(10)
                .font(.caption)
                .bold()
                .foregroundStyle(style.foreground)
                .background(style.background)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(style.foreground, lineWidth: style.lineWidth)
                }
        }
        .frame(maxWidth: .infinity)
    }
}


#Preview {
    WeeklyCalendar()
}

