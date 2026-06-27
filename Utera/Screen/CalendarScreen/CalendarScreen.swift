//
//  CalendarScreen.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI
import SwiftData

struct CalendarScreen: View {
    // MARK: - Query
    @Query private var cyclesPredicted: [CyclePredictModel]
    private var cyclePredicted: CyclePredictModel? { cyclesPredicted.first }

    // MARK: - State
    @State private var currentMonth: Date = .now
    @State private var selectedDate: Date = .now

    private var cyclePromptTask: CyclePromptTask? {
        guard let p = cyclePredicted else { return nil }
        return CyclePromptTask(
            fertileWindowStart: p.fertileWindowStart,
            fertileWindowEnd: p.fertileWindowEnd,
            nextPeriodDate: p.nextPeriodDate,
            advise: p.advise,
        )
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Calendar")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color("TextPrimary"))

                MonthlyCalendar(currentMonth: $currentMonth, cyclePredicted: cyclePromptTask)

                if let predicted = cyclePredicted {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("This cycle")
                            .font(.caption)
                            .foregroundStyle(Color("TextSecondary"))

                        AppSectionInput {
                            Circle()
                                .fill(Color("System"))
                                .frame(width: 10, height: 10)
                            VStack(alignment: .leading) {
                                Text("Fertile window")
                                    .font(.caption)
                                    .bold()
                                    .foregroundStyle(Color("TextPrimary"))
                                if let start = predicted.fertileWindowStart.toDate(),
                                     let end = predicted.fertileWindowEnd.toDate() {
                                      Text("\(start.formatted(.dateTime.month(.abbreviated).day())) – \(end.formatted(.dateTime.month(.abbreviated).day()))")
                                          .font(.caption2)
                                          .foregroundStyle(Color("TextSecondary"))
                                  }
                            }
                        }

                        AppSectionInput {
                            Circle()
                                .fill(Color("Primary"))
                                .frame(width: 10, height: 10)
                            VStack(alignment: .leading) {
                                Text("Next period")
                                    .font(.caption)
                                    .bold()
                                    .foregroundStyle(Color("TextPrimary"))
                                Text(predicted.nextPeriodDate.toDate() ?? .now, format: .dateTime.weekday(.wide).month(.abbreviated).day())
                                    .font(.caption2)
                                    .foregroundStyle(Color("TextSecondary"))
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 12)
        }
    }
}

extension String {
     func toDate(format: String = "yyyy-MM-dd") -> Date? {
         let formatter = DateFormatter()
         formatter.dateFormat = format
         return formatter.date(from: self)
     }
 }

#Preview {
    ZStack {
        Color("Background")
            .ignoresSafeArea(.all)

        CalendarScreen()
    }
    .modelContainer(for: [CyclePredictModel.self], inMemory: true)
}
