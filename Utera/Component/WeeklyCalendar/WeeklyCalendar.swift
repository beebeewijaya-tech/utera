//
//  WeeklyCalendar.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI

enum WeeklyCellStyle {
    case active, inactive, ovulation
    
    
    var background: Color {
        switch self {
        case .active:
            return .white
            
        case .inactive:
            return .clear
            
        case .ovulation:
            return Color("System")
        }
    }
    
    var foreground: Color {
        switch self {
        case .active:
            return Color("Primary")
            
        case .inactive:
            return Color("TextPrimary")

        case .ovulation:
            return .white
        }
    }
    
    var lineWidth: CGFloat {
        switch self {
        case .active:
            return 2
            
        case .inactive, .ovulation:
            return 0
        }
    }
}

struct WeeklyCalendar: View {
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
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Array(weekDates.enumerated()), id: \.offset) { id, d in
                    let dayNumber = Calendar.current.component(.day, from: d)
                    let isToday = Calendar.current.isDateInToday(d)
                    WeeklyCell(label: "\(weekLetters[id])", date: "\(dayNumber)", style: isToday ? .active : .inactive)
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

