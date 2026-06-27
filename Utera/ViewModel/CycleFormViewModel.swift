//
//  CycleFormViewModel.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI
import SwiftData

@Observable
final class CycleFormViewModel {
    var date = Date()
    var avgCycle: Int = 0
    var avgPeriod: Int = 0
    var cycleRegular: String = ""
    var trackingGoal: String = ""
    var hasSubmitted: Bool = false
    
    var dateError: String? {
        guard hasSubmitted else { return nil }
        
        if date > .now {
            return "Date can't be in the future"
        }
        
        return nil
    }
    
    var avgCycleError: String? {
        guard hasSubmitted else { return nil }
        if avgCycle < 1 {
            return "Average cycle need to be fill"
        }
        
        return nil
    }
    
    var avgPeriodError: String? {
        guard hasSubmitted else { return nil }
        if avgCycle < 1 {
            return "Average period need to be fill"
        }
        
        return nil
    }
    
    var cycleRegularError: String? {
        guard hasSubmitted else { return nil }
        if cycleRegular == "" {
            return "Please select the cycle regular"
        }
        
        return nil
    }
    
    var trackingGoalError: String? {
        guard hasSubmitted else { return nil }
        if trackingGoal == ""{
            return "Please select the tracking goal"
        }
        
        return nil
    }
    
    var errors: [String] {
        [dateError, avgCycleError, avgPeriodError, cycleRegularError, trackingGoalError].compactMap { $0 }
    }
    
    var isFormValid: Bool {
        errors.isEmpty
    }
    
    func submit(context: ModelContext) -> Bool {
        hasSubmitted = true
        guard isFormValid else { return false }
        
        let cycleForm = CycleModel(
            date: date,
            avgCycle: avgCycle,
            avgPeriod: avgPeriod,
            cycleRegular: cycleRegular,
            trackingGoal: trackingGoal,
            hasSubmitted: hasSubmitted
        )
        
        print("cycleForm: \(cycleForm)")
        context.insert(cycleForm)
        return true
    }
}
