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
    @Test("rejecting non date")
    func rejectNonDate() {
        let cycleStorage = FakeCycleStorage()
        let viewModel = CycleFormViewModel(cycleStorage: cycleStorage)
        let res = viewModel.submit()

        viewModel.date = .distantFuture

        #expect(viewModel.dateError != nil)
        #expect(viewModel.hasSubmitted == true)
        #expect(res == false)
        #expect(cycleStorage.saveCalled == 0)
    }

    @Test("rejecting avg cycle")
    func rejectAvgCycle() {
        let cycleStorage = FakeCycleStorage()
        let viewModel = CycleFormViewModel(cycleStorage: cycleStorage)

        viewModel.date = .distantPast

        let res = viewModel.submit()
        #expect(viewModel.avgCycleError != nil)
        #expect(viewModel.hasSubmitted == true)
        #expect(res == false)
        #expect(cycleStorage.saveCalled == 0)
    }

    @Test("rejecting avg period")
    func rejectAvgPeriod() {
        let cycleStorage = FakeCycleStorage()
        let viewModel = CycleFormViewModel(cycleStorage: cycleStorage)

        viewModel.date = .distantPast
        viewModel.avgCycle = 1

        let res = viewModel.submit()

        #expect(viewModel.avgPeriodError != nil)
        #expect(viewModel.hasSubmitted == true)
        #expect(res == false)
        #expect(cycleStorage.saveCalled == 0)
    }

    @Test("rejecting cycle regular")
    func rejectCycleRegular() {
        let cycleStorage = FakeCycleStorage()
        let viewModel = CycleFormViewModel(cycleStorage: cycleStorage)

        viewModel.date = .distantPast
        viewModel.avgCycle = 1
        viewModel.avgPeriod = 1

        let res = viewModel.submit()

        #expect(viewModel.cycleRegularError != nil)
        #expect(viewModel.hasSubmitted == true)
        #expect(res == false)
        #expect(cycleStorage.saveCalled == 0)
    }

    @Test("rejecting tracking goal")
    func rejectTrackingGoal() {
        let cycleStorage = FakeCycleStorage()
        let viewModel = CycleFormViewModel(cycleStorage: cycleStorage)

        viewModel.date = .distantPast
        viewModel.avgCycle = 1
        viewModel.avgPeriod = 1
        viewModel.cycleRegular = "Pretty regular"

        let res = viewModel.submit()
        #expect(viewModel.trackingGoalError != nil)
        #expect(viewModel.hasSubmitted == true)
        #expect(res == false)
        #expect(cycleStorage.saveCalled == 0)
    }

    @Test("success scenario")
    func successScenario() {
        let cycleStorage = FakeCycleStorage()
        let viewModel = CycleFormViewModel(cycleStorage: cycleStorage)

        viewModel.date = .distantPast
        viewModel.avgCycle = 1
        viewModel.avgPeriod = 1
        viewModel.cycleRegular = "Pretty regular"
        viewModel.trackingGoal = "General tracking"

        let res = viewModel.submit()
        #expect(viewModel.hasSubmitted == true)
        #expect(res == true)
        #expect(cycleStorage.saveCalled == 1)
    }
}
