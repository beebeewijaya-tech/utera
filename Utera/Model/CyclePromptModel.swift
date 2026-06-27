//
//  CyclePromptModel.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI
import FoundationModels
import SwiftData


@Model
class CyclePredictModel {
    var fertileWindowStart: String
    var fertileWindowEnd: String
    var nextPeriodDate: String
    var advise: String

    init(fertileWindowStart: String, fertileWindowEnd: String, nextPeriodDate: String, advise: String) {
        self.fertileWindowStart = fertileWindowStart
        self.fertileWindowEnd = fertileWindowEnd
        self.nextPeriodDate = nextPeriodDate
        self.advise = advise
    }
}


@Generable
struct CyclePromptTask {
    @Guide(description: "Start of fertile window in YYYY-MM-DD format")
    var fertileWindowStart: String
    
    @Guide(description: "End of fertile window in YYYY-MM-DD format")
    var fertileWindowEnd: String
    
    @Guide(description: "Next predicted period start date in YYYY-MM-DD format")
    var nextPeriodDate: String
    
    @Guide(description: "Short personalized advice based on the user's tracking goal")
    var advise: String
}
