//
//  MonthlyCalendar.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI

struct MonthlyCalendar: View {
    @Binding var currentMonth: Date
    var cyclePredicted: CyclePromptTask?

    private let calendar = Calendar.current
    private let weekLetters = ["M", "T", "W", "T", "F", "S", "S"]
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    private var firstDayOfMonth: Date {
        calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth))!
    }

    private var daysInMonth: Int {
        calendar.range(of: .day, in: .month, for: currentMonth)!.count
    }

    private var startOffset: Int {
        let weekday = calendar.component(.weekday, from: firstDayOfMonth)
        return (weekday + 5) % 7 // Monday-based offset
    }

    private var monthDates: [Date?] {
        var dates: [Date?] = Array(repeating: nil, count: startOffset)
        for day in 1...daysInMonth {
            dates.append(calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth))
        }
        return dates
    }

    private var indicators: [Date: WeeklyCellStyle] {
        var result: [Date: WeeklyCellStyle] = [:]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        guard let predicted = cyclePredicted,
              let start = formatter.date(from: predicted.fertileWindowStart),
              let end = formatter.date(from: predicted.fertileWindowEnd),
              let nextPeriod = formatter.date(from: predicted.nextPeriodDate)
        else { return result }

        let days = calendar.dateComponents([.day], from: start, to: end).day ?? 0
        for offset in 0...days {
            if let day = calendar.date(byAdding: .day, value: offset, to: start) {
                result[calendar.startOfDay(for: day)] = .ovulation
            }
        }
        result[calendar.startOfDay(for: end)] = .ovulation
        result[calendar.startOfDay(for: nextPeriod)] = .period

        return result
    }

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Button {
                    currentMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth)!
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color("TextSecondary"))
                }

                Spacer()

                Text(currentMonth.formatted(.dateTime.month(.wide).year()))
                    .font(.callout)
                    .bold()
                    .foregroundStyle(Color("TextPrimary"))

                Spacer()

                Button {
                    currentMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth)!
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color("TextSecondary"))
                }
            }

            HStack {
                ForEach(weekLetters, id: \.self) { letter in
                    Text(letter)
                        .font(.caption2)
                        .foregroundStyle(Color("TextSecondary"))
                        .frame(maxWidth: .infinity)
                }
            }

            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(Array(monthDates.enumerated()), id: \.offset) { _, date in
                    if let date {
                        let dayNumber = calendar.component(.day, from: date)
                        let isToday = calendar.isDateInToday(date)
                        let key = calendar.startOfDay(for: date)
                        let style: WeeklyCellStyle = isToday ? .active : (indicators[key] ?? .inactive)

                        WeeklyCell(label: "", date: "\(dayNumber)", style: style)
                    } else {
                        Color.clear.frame(height: 36)
                    }
                }
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 10)
    }
}

#Preview {
    MonthlyCalendar(currentMonth: .constant(.now))
        .padding()
        .background(Color("Background"))
}
