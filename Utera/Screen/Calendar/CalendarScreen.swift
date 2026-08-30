//
//  CalendarScreen.swift
//  Utera
//
//  Created by Bee Wijaya on 28/08/26.
//

import SwiftUI

struct CalendarScreen: View {
    // MARK: - ViewModel
    @Environment(CalendarViewModel.self) private var calendarVM
    
    // MARK: - State
    private var columns = Array(repeating: GridItem(.fixed(40)), count: 7)
    private var legends: [DayStyle] = [
        .active,
        .inactive,
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
                
                Spacer()
                
                Text("August 2026")
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
                
            }
            .padding(.bottom, 24)
            
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
            
            VStack(alignment: .leading) {
                ForEach(legends, id: \.self) { legend in
                    HStack {
                        Circle()
                            .fill(legend.labelColor)
                            .frame(width: 5, height: 5)
                        
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
        }
    }
}

#Preview {
    CalendarScreen()
        .environment(CalendarViewModel())
}
