//
//  CalendarViewModel.swift
//  Utera
//
//  Created by Bee Wijaya on 28/08/26.
//

import SwiftUI

struct DateCell: Identifiable, Hashable {
    var id: UUID = UUID()
    var date: Date?
}

@Observable
class CalendarViewModel {
    var calendar = Calendar.current
    let date = Date()
    let weeks = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

    var component = DateComponents()
    var selectedMonth: Int = 0
    var selectedYear: Int = 0
    var dates: [DateCell] = []
    
    init() {
        calendar.firstWeekday = 1
        getCurrentMonth()
    }
    
    func getCurrentMonth() {
        selectedMonth = calendar.component(.month, from: date)
        selectedYear = calendar.component(.year, from: date)

        component.year = selectedYear
        component.month = selectedMonth
    }
    
    func setMonth(month: Int) {
        selectedMonth = month
        component.month = month
        
        getDaysInCurrentMonth()
    }
    
    func getDaysInCurrentMonth() {
        if let date = calendar.date(from: component) {
            guard let interval = calendar.dateInterval(of: .month, for: date),
                  let range = calendar.range(of: .day, in: .month, for: date) else {
                return
            }
            
            let firstDayOfMonth = interval.start
            
            // get which day is that firstDayOfMonth is
            let weekday = calendar.component(
                .weekday,
                from: firstDayOfMonth
            )
            
            // how many blank before first day, to get where the firstDayOfMonth in which day
            let leading = (weekday - calendar.firstWeekday) % 7
            
            let blanks: [DateCell] = (0..<leading).map { _ in DateCell() }
            let dateCells: [DateCell] = range.map {
                DateCell(
                    date: calendar.date(
                        byAdding: .day,
                        value: $0 - 1,
                        to: firstDayOfMonth
                    )
                )
            }
            dates = blanks + dateCells
        }
    }
    
    func label(date: Date?) -> String {
        guard let date else { return "" }
        return "\(calendar.component(.day, from: date))"
    }
    
    func getStyle(date: Date?) -> DayStyle {
        guard let date else { return .inactive }
        
        let isToday = calendar.isDateInToday(date)
        if isToday {
            return .active
        }
        
        return .inactive
    }
}
