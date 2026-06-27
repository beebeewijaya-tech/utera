//
//  ProfileViewModel.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI
import SwiftData

@Observable
final class ProfileViewModel {
    var date: Date = .now
    var avgCycle: Int = 0
    var avgPeriod: Int = 0
    var selectedCycleRegular: String = ""
    var selectedTrackingGoal: String = ""
    var notificationDays: String = ""

    let cycleRegularOptions = ["Pretty regular", "Varies a lot", "Not sure"]
    let trackingGoalOptions = ["General tracking", "Trying to conceive", "Avoiding pregnancy"]
    let daysOptions = ["3", "5", "7"]

    func load(cycle: CycleModel?, notification: NotificationModel?) {
        if let cycle {
            date = cycle.date
            avgCycle = cycle.avgCycle
            avgPeriod = cycle.avgPeriod
            selectedCycleRegular = cycle.cycleRegular
            selectedTrackingGoal = cycle.trackingGoal
        }
        if let notification {
            notificationDays = String(notification.days)
        }
    }

    func save(cycle: CycleModel?, notification: NotificationModel?, context: ModelContext) {
        guard let cycle, let notification else { return }

        cycle.date = date
        cycle.avgCycle = avgCycle
        cycle.avgPeriod = avgPeriod
        cycle.cycleRegular = selectedCycleRegular
        cycle.trackingGoal = selectedTrackingGoal
        notification.days = Int(notificationDays) ?? 0

        try? context.save()
    }
}
