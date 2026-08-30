//
//  AppWeeklyCalendar.swift
//  Utera
//
//  Created by Bee Wijaya on 28/08/26.
//

import SwiftUI

struct AppWeeklyCalendar: View {
    @State private var currentDate = Date.now
    
    var body: some View {
        HStack {
            ForEach(0 ... 5, id: \.self) { idx in
                AppDayPill(label: "\(idx)", style: .active)
            }
        }
    }
}

#Preview {
    AppWeeklyCalendar()
}
