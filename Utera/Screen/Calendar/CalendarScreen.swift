//
//  CalendarScreen.swift
//  Utera
//
//  Created by Bee Wijaya on 28/08/26.
//

import SwiftData
import SwiftUI

struct CalendarScreen: View {
    // MARK: - ViewModel
    @Environment(CalendarViewModel.self) private var calendarVM
    
    // MARK: - State
    private var columns = Array(repeating: GridItem(.fixed(40)), count: 7)
    private var legends: [DayStyle] = [
        .active,
        .inactive,
        .fertile,
        .peak,
        .period
    ]
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                    .frame(width: 40, height: 40)
                    .background(.white)
                    .foregroundStyle(.black)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 1)
                    .onTapGesture {
                        calendarVM.setMonth(month: calendarVM.selectedMonth - 1)
                    }
                
                Spacer()
                
                Text(calendarVM.monthLabel())
                    .font(.title3)
                    .bold()
                    .foregroundStyle(Color("Primary"))
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .frame(width: 40, height: 40)
                    .background(.white)
                    .foregroundStyle(.black)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 1)
                    .onTapGesture {
                        calendarVM.setMonth(month: calendarVM.selectedMonth + 1)
                    }
                
            }
            .padding(.bottom, 24)
            
            switch calendarVM.state {
            case .loading:
                ProgressView()
            case .idle:
                if calendarVM.dates.count > 1 {
                    LazyVGrid(columns: columns) {
                        ForEach(calendarVM.weeks, id: \.self) { weeks in
                            if let week = weeks.first {
                                Text("\(week)")
                                    .foregroundStyle(Color("Primary"))
                                    .bold()
                            }
                        }
                        
                        ForEach(calendarVM.dates, id: \.id) { day in
                            AppDayPill(
                                label: calendarVM.label(date: day.date),
                                style: calendarVM.getStyle(date: day.date),
                                empty: day.date == nil
                            )
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
            
            VStack(alignment: .leading) {
                ForEach(legends, id: \.self) { legend in
                    HStack {
                        switch legend {
                        case .fertile:
                            Circle()
                                .stroke(style: StrokeStyle(lineWidth: 1))
                                .fill(legend.labelColor)
                                .frame(width: 10, height: 10)
                        case .peak:
                            Circle()
                                .stroke(style: StrokeStyle(lineWidth: 3))
                                .fill(legend.labelColor)
                                .frame(width: 10, height: 10)
                        default:
                            Circle()
                                .fill(legend.labelColor)
                                .frame(width: 10, height: 10)
                        }
                        
                        Text(legend.label)
                            .foregroundStyle(legend.labelColor)
                            .font(.caption)
                            .bold()
                    }
                }
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .padding()
        .task {
            calendarVM.getDaysInCurrentMonth()
            calendarVM.setCycle()
        }
    }
}

#Preview {
    CalendarScreen()
        .environment(CalendarViewModel(
            cyclePromptStorage: CyclePromptStorage(context: PreviewContainer.shared.mainContext),
            cycleStorage: CycleStorage(context: PreviewContainer.shared.mainContext)
        ))
}
