//
//  AppWeeklyCalendar.swift
//  Utera
//
//  Created by Bee Wijaya on 28/08/26.
//

import SwiftUI

struct AppWeeklyCalendar: View {
    var body: some View {
        HStack {
            ForEach(0 ... 5, id: \.self) { _ in
//                AppDayPill(label: , style: <#T##DayStyle#>)
            }
        }
    }
}

#Preview {
    AppWeeklyCalendar()
}
