//
//  ProfileViewModel.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI
import SwiftData

enum ProfileState: Equatable {
    case error(String)
    case success
    case loading
    case idle
}

@Observable
final class ProfileViewModel {
    var date: Date = .now
    var avgCycle: Int = 0
    var avgPeriod: Int = 0
    var selectedCycleRegular: String = ""
    var selectedTrackingGoal: String = ""
    var notificationDays: String = ""
    var dismissTask: Task<Void, Never>?

    // constant
    let cycleRegularOptions = ["Pretty regular", "Varies a lot", "Not sure"]
    let trackingGoalOptions = ["General tracking", "Trying to conceive", "Avoiding pregnancy"]
    let daysOptions = ["3", "5", "7"]

    // screen state
    var state: ProfileState = .idle

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
        dismissTask?.cancel()
        state = .loading
        
        do {
            if let cycle { context.delete(cycle) }
            if let notification { context.delete(notification) }

            context.insert(
                CycleModel(
                    date: date,
                    avgCycle: avgCycle,
                    avgPeriod: avgPeriod,
                    cycleRegular: selectedCycleRegular,
                    trackingGoal: selectedTrackingGoal,
                )
            )
            context.insert(NotificationModel(days: Int(notificationDays) ?? 0))

            try context.save()
            state = .success
        } catch {
            state = .error(error.localizedDescription)
        }
        
        // save the task dismiss
        // hence we can cancel it & control over it
        dismissTask = Task {
            try? await Task.sleep(for: .seconds(2))
            state = .idle
        }
    }
}
