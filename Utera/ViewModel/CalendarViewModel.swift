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

enum CalendarState: Hashable {
    case idle
    case loading
}

@Observable
class CalendarViewModel {
    private var calendar = Calendar.current
    let date = Date()
    let weeks = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

    private var component = DateComponents()
    var selectedMonth: Int = 0
    var selectedYear: Int = 0
    var dates: [DateCell] = []
    var state: CalendarState = .idle
    var fertileWindow: [Date?] = []
    var nextPeriodWindow: [Date?] = []
    var ovulationDay: Int = 0
    var advise: String = ""
    
    // MARK: - Props
    private var cyclePromptStorage: ICyclePromptStorage
    private var cycleStorage: ICycleStorage

    init(cyclePromptStorage: ICyclePromptStorage, cycleStorage: ICycleStorage) {
        self.cyclePromptStorage = cyclePromptStorage
        self.cycleStorage = cycleStorage
        
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
        guard state == .idle else { return }
        state = .loading
        defer { state = .idle }
        
        selectedMonth = month
        component.month = month
        
        getDaysInCurrentMonth()
    }
    
    func setCycle() {
        do {
            let cyclePredict = try cyclePromptStorage.load()
            let cycle = try cycleStorage.load()
            guard let cyclePredict, let cycle else { return }
            
            advise = cyclePredict.advise
            getFertileWindow(cyclePredict: cyclePredict)
            getNextPeriodWindow(cyclePredict: cyclePredict, cycle: cycle)
        } catch {
            print("Error: \(error)")
        }
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
        
        if calendar.isDateInToday(date) { return .active }
        if nextPeriodWindow.contains(date) { return .period }
        if fertileWindow.contains(date) { return .fertile }
        
        return .inactive
    }
    
    func monthLabel() -> String {
        let date = calendar.date(from: component)
        guard let date else { return "" }
        
        return date.formatted(.dateTime.month(.wide).year())
    }
    
    func getOvulation() {
        guard let fertilityEnd = fertileWindow.last, let fertilityEnd else { return }
        let different = calendar.dateComponents([.day], from: .now, to: fertilityEnd)
        
        guard let day = different.day else { return }
        if day <= 2 {
            ovulationDay = day
        }
    }
    
    func getNearestFertile() -> Int {
        guard let fertilityStart = fertileWindow.first, let fertilityStart else { return 0 }
        let different = calendar.dateComponents([.day], from: .now, to: fertilityStart)
        
        return different.day ?? 0
    }
    
    // MARK: - Internal function
    private func parseDate(date: String) -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: date) ?? .now
    }
    
    private func getFertileWindow(cyclePredict: CyclePredictModel) {
        let fertileWindowStart = parseDate(date: cyclePredict.fertileWindowStart)
        let fertileWindowEnd = parseDate(date: cyclePredict.fertileWindowEnd)
        let fertileDaysDifferent = calendar.dateComponents([.day], from: fertileWindowStart, to: fertileWindowEnd)
        guard let fertileDays = fertileDaysDifferent.day else { return }
        fertileWindow = (0...fertileDays).map { calendar.date(byAdding: .day, value: $0, to: fertileWindowStart) }
    }
    
    private func getNextPeriodWindow(cyclePredict: CyclePredictModel, cycle: CycleModel) {
        let nextPeriod = parseDate(date: cyclePredict.nextPeriodDate)
        let avgPeriod = cycle.avgPeriod
        nextPeriodWindow = (0...avgPeriod).map { calendar.date(byAdding: .day, value: $0, to: nextPeriod )}
    }
}
