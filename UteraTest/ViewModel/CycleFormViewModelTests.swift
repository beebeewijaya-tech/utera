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
        let vm = CycleFormViewModel()
        let res = vm.submit(context: container.mainContext)
        
        vm.date = .distantFuture
        
        #expect(vm.dateError != nil)
        #expect(vm.hasSubmitted == true)
        #expect(res == false)
    }
    
    @Test("rejecting avg cycle")
    func rejectAvgCycle() {
        let vm = CycleFormViewModel()
        
        vm.date = .distantPast
        
        let res = vm.submit(context: container.mainContext)
        #expect(vm.avgCycleError != nil)
        #expect(vm.hasSubmitted == true)
        #expect(res == false)
    }
    
    @Test("rejecting avg period")
    func rejectAvgPeriod() {
        let vm = CycleFormViewModel()
        
        vm.date = .distantPast
        vm.avgCycle = 1
        
        let res = vm.submit(context: container.mainContext)
        
        #expect(vm.avgPeriodError != nil)
        #expect(vm.hasSubmitted == true)
        #expect(res == false)
    }
    
    @Test("rejecting cycle regular")
    func rejectCycleRegular() {
        let vm = CycleFormViewModel()
        
        vm.date = .distantPast
        vm.avgCycle = 1
        vm.avgPeriod = 1
        
        let res = vm.submit(context: container.mainContext)
        
        #expect(vm.cycleRegularError != nil)
        #expect(vm.hasSubmitted == true)
        #expect(res == false)
    }
    
    @Test("rejecting tracking goal")
    func rejectTrackingGoal() {
        let vm = CycleFormViewModel()
        
        vm.date = .distantPast
        vm.avgCycle = 1
        vm.avgPeriod = 1
        vm.cycleRegular = "Pretty regular"
        
        let res = vm.submit(context: container.mainContext)
        #expect(vm.trackingGoalError != nil)
        #expect(vm.hasSubmitted == true)
        #expect(res == false)
    }
    
    
    @Test("success scenario")
    func successScenario() {
        let vm = CycleFormViewModel()
        
        vm.date = .distantPast
        vm.avgCycle = 1
        vm.avgPeriod = 1
        vm.cycleRegular = "Pretty regular"
        vm.trackingGoal = "General tracking"
        
        let res = vm.submit(context: container.mainContext)
        #expect(vm.hasSubmitted == true)
        #expect(res == true)
    }
}
