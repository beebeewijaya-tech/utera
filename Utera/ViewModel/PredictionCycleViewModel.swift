//
//  PredictionCycleViewModel.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import FoundationModels
import SwiftData
import SwiftUI

enum PredictionCycleState: Equatable {
    case idle
    case error(String)
    case loading
}

@Observable
final class PredictionCycleViewModel {
    // MARK: - State

    var date: Date = .now
    var avgCycle: Int = 0
    var avgPeriod: Int = 0
    var selectedCycleRegular: String = ""
    var selectedTrackingGoal: String = ""
    var result: CyclePromptTask?
    var state: PredictionCycleState = .idle

    // MARK: - Props
    var llm: any ILLMManager<CyclePromptTask>
    var cyclePromptStorage: ICyclePromptStorage

    init(
        llm: any ILLMManager<CyclePromptTask> = LLMManager(),
        cyclePromptStorage: ICyclePromptStorage
    ) {
        self.llm = llm
        self.cyclePromptStorage = cyclePromptStorage
    }

    func generate() async {
        guard state != .loading else { return } // prevent double submit / race cond
        state = .loading

        do {
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
            result = try await llm.generate(prompt: prompt)
            if let result {
                try cyclePromptStorage.save(result: result)
            }
            
            state = .idle
        } catch {
            state = .error(error.localizedDescription)
        }
    }

    func load(cycle: CycleModel?, cyclePredicted: CyclePredictModel?) async {
        guard let cycle else { return }

        // cycle
        date = cycle.date
        avgCycle = cycle.avgCycle
        avgPeriod = cycle.avgPeriod
        selectedCycleRegular = cycle.cycleRegular
        selectedTrackingGoal = cycle.trackingGoal

        guard let cyclePredicted else {
            // not found will generate the prompt
            await generate()
            return
        }

        // cycle prompt
        result = CyclePromptTask(
            fertileWindowStart: cyclePredicted.fertileWindowStart,
            fertileWindowEnd: cyclePredicted.fertileWindowEnd,
            nextPeriodDate: cyclePredicted.nextPeriodDate,
            advise: cyclePredicted.advise
        )
    }
}
