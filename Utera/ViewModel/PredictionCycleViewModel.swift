//
//  PredictionCycleViewModel.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI
import FoundationModels
import SwiftData


@Observable
final class PredictionCycleViewModel {
    var date: Date = .now
    var avgCycle: Int = 0
    var avgPeriod: Int = 0
    var selectedCycleRegular: String = ""
    var selectedTrackingGoal: String = ""
    var isLoading = false
    var err = ""
    var result: CyclePromptTask?
    
    
    func generate(modelContext: ModelContext) async {
        isLoading = true
        do {
            let model = SystemLanguageModel.default
            guard case .available = model.availability else {
                err = "Apple intelligence not available"
                return
            }
            let prompt = """
                Based on this user's cycle data, predict their cycle information.
                  
                  - Current Date: \(Date.now)
                  - Last period started: \(date.formatted(.dateTime.year().month().day()))
                  - Average cycle length: \(avgCycle) days
                  - Average period length: \(avgPeriod) days
                  - Cycle regularity: \(selectedCycleRegular)
                  - Tracking goal: \(selectedTrackingGoal)
                  - Today's date: \(Date.now.formatted(.dateTime.year().month().day()))

                  Calculate using standard cycle science:
                  - Ovulation typically occurs on cycle day \(avgCycle - 14)
                  - Fertile window is 5 days before ovulation through ovulation day
            """
            let session = LanguageModelSession()
            let response = try await session.respond(to: prompt, generating: CyclePromptTask.self)
            
            result = response.content
            
            if result != nil {
                modelContext.insert(CyclePredictModel(fertileWindowStart: result!.fertileWindowStart, fertileWindowEnd: result!.fertileWindowEnd, nextPeriodDate: result!.nextPeriodDate, advise: result!.advise))
            }
            isLoading = false
        } catch {
            isLoading = false
            err = error.localizedDescription
        }
    }
    
    func load(cycle: CycleModel?, cyclePredicted: CyclePredictModel?) {
        isLoading = true
        if let cycle = cycle {
            date = cycle.date
            avgCycle = cycle.avgCycle
            avgPeriod = cycle.avgPeriod
            selectedCycleRegular = cycle.cycleRegular
            selectedTrackingGoal = cycle.trackingGoal
        }
        
        if let cyclePredicted = cyclePredicted {
            result = CyclePromptTask(
                fertileWindowStart: cyclePredicted.fertileWindowStart, fertileWindowEnd: cyclePredicted.fertileWindowEnd, nextPeriodDate: cyclePredicted.nextPeriodDate, advise: cyclePredicted.advise
            )
        }
    }
}
