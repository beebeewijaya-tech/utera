//
//  CycleStorage.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI
import SwiftData


@Model
class CycleModel {
    var date: Date
    var avgCycle: Int
    var avgPeriod: Int
    var cycleRegular: String
    var trackingGoal: String
    var hasSubmitted: Bool
    
    init(date: Date, avgCycle: Int, avgPeriod: Int, cycleRegular: String, trackingGoal: String, hasSubmitted: Bool) {
        self.date = date
        self.avgCycle = avgCycle
        self.avgPeriod = avgPeriod
        self.cycleRegular = cycleRegular
        self.trackingGoal = trackingGoal
        self.hasSubmitted = hasSubmitted
    }
}
