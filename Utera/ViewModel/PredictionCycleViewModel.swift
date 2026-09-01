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
        llm: any ILLMManager<CyclePromptTask> = LLMGemini(),
        cyclePromptStorage: ICyclePromptStorage
    ) {
        self.llm = llm
        self.cyclePromptStorage = cyclePromptStorage
    }
    
    func generate() async {
        guard state != .loading else { return } // prevent double submit / race cond
        state = .loading
        
        do {
            let today = Date.now.formatted(.dateTime.year().month().day())
            let prompt = """
              Based on this user's cycle data, predict their UPCOMING cycle information.
              All predictions must be in the future relative to today.
          
              - Today's date: \(today)
              - Last recorded period start: \(date.formatted(.dateTime.year().month().day()))
              - Average cycle length: \(avgCycle) days
              - Average period length: \(avgPeriod) days
              - Cycle regularity: \(selectedCycleRegular)
              - Tracking goal: \(selectedTrackingGoal)
          
              IMPORTANT - the last recorded period start is a historical anchor and may be \
              several cycles in the past. Do not treat it as the current cycle. First roll it \
              forward by whole multiples of \(avgCycle) days until you reach the most recent \
              cycle start that is on or before today (\(today)). Call that the current cycle \
              start, and base every calculation on it.
          
              Then calculate using standard cycle science:
              - Next period start = current cycle start + \(avgCycle) days
              - Ovulation occurs on cycle day \(avgCycle - 14), counting from the current cycle start
              - Fertile window is 5 days before ovulation through ovulation day
          
              Hard rules for the returned dates:
              - nextPeriodDate must be strictly after \(today). Never return a past date.
              - fertileWindowEnd must be on or after \(today). If the fertile window derived \
              from the current cycle has already fully passed, advance one more cycle and \
              return the next upcoming fertile window instead.
              - fertileWindowStart must be before fertileWindowEnd, and both must fall within \
              the same cycle as nextPeriodDate or the cycle immediately preceding it.
              - Before answering, verify every date you return is not earlier than \(today). \
              If any date is in the past, add \(avgCycle) days and recalculate.
          
              For the "advise" field, write 4 to 6 sentences (roughly 70-110 words) of warm, \
              practical guidance addressed directly to the user as "you". It must:
              1. Say where she is in her cycle right now (period, follicular, fertile window, \
              or luteal) and how many days until the next key date.
              2. Give 2 to 3 concrete actions for the next few days that match her tracking \
              goal "\(selectedTrackingGoal)" - for example timing intimacy, logging symptoms, \
              tracking basal body temperature or cervical mucus, preparing period supplies, \
              iron-rich food, hydration, sleep, or easing training load.
              3. Mention what she may notice in her body or mood during this phase, so the \
              advice feels personal instead of generic.
              4. Reflect her cycle regularity "\(selectedCycleRegular)". If it is irregular, \
              say the prediction is an estimate and suggest logging a few more cycles or \
              talking to a clinician.
          
              Rules for "advise":
              - Plain conversational text only. No markdown, no bullet points, no headings, \
              no numbered lists, no emoji. It is rendered as one paragraph.
              - Refer to dates naturally ("in about 5 days") rather than repeating the raw \
              YYYY-MM-DD values already returned in the other fields.
              - Never frame it as contraception, diagnosis, or medical advice.
          """
            result = try await llm.generate(prompt: prompt)
            if let result {
                try cyclePromptStorage.save(result: result)
            }
            
            state = .idle
        } catch {
            print(error.localizedDescription)
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
