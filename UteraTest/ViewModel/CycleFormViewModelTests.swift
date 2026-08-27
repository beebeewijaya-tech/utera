//
//  CycleFormViewModelTests.swift
//  Utera
//
//  Created by Bee Wijaya on 26/08/26.
//

import Foundation
import SwiftData
import Testing

@testable import YoUtera

@MainActor
@Suite("Cycle Form Tests")
struct CycleFormViewModelTests {
    var container: ModelContainer
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        self.container = try ModelContainer(for: CycleModel.self, configurations: config)
    }
    
    
    @Test("rejecting non date")
    func rejectNonDate() {
        let viewModel = CycleFormViewModel()
        let res = viewModel.submit(context: container.mainContext)
        
        viewModel.date = .distantFuture
        
        #expect(viewModel.dateError != nil)
        #expect(viewModel.hasSubmitted == true)
        #expect(res == false)
    }
    
    @Test("rejecting avg cycle")
    func rejectAvgCycle() {
        let viewModel = CycleFormViewModel()
        
        viewModel.date = .distantPast
        
        let res = viewModel.submit(context: container.mainContext)
        #expect(viewModel.avgCycleError != nil)
        #expect(viewModel.hasSubmitted == true)
        #expect(res == false)
    }
    
    @Test("rejecting avg period")
    func rejectAvgPeriod() {
        let viewModel = CycleFormViewModel()
        
        viewModel.date = .distantPast
        viewModel.avgCycle = 1
        
        let res = viewModel.submit(context: container.mainContext)
        
        #expect(viewModel.avgPeriodError != nil)
        #expect(viewModel.hasSubmitted == true)
        #expect(res == false)
    }
    
    @Test("rejecting cycle regular")
    func rejectCycleRegular() {
        let viewModel = CycleFormViewModel()
        
        viewModel.date = .distantPast
        viewModel.avgCycle = 1
        viewModel.avgPeriod = 1
        
        let res = viewModel.submit(context: container.mainContext)
        
        #expect(viewModel.cycleRegularError != nil)
        #expect(viewModel.hasSubmitted == true)
        #expect(res == false)
    }
    
    @Test("rejecting tracking goal")
    func rejectTrackingGoal() {
        let viewModel = CycleFormViewModel()
        
        viewModel.date = .distantPast
        viewModel.avgCycle = 1
        viewModel.avgPeriod = 1
        viewModel.cycleRegular = "Pretty regular"
        
        let res = viewModel.submit(context: container.mainContext)
        #expect(viewModel.trackingGoalError != nil)
        #expect(viewModel.hasSubmitted == true)
        #expect(res == false)
    }
    
    
    @Test("success scenario")
    func successScenario() {
        let viewModel = CycleFormViewModel()
        
        viewModel.date = .distantPast
        viewModel.avgCycle = 1
        viewModel.avgPeriod = 1
        viewModel.cycleRegular = "Pretty regular"
        viewModel.trackingGoal = "General tracking"
        
        let res = viewModel.submit(context: container.mainContext)
        #expect(viewModel.hasSubmitted == true)
        #expect(res == true)
    }
}
