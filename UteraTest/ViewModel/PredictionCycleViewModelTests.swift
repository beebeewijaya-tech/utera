//
//  PredictionCycleViewModelTests.swift
//  Utera
//
//  Created by Bee Wijaya on 28/08/26.
//

import Foundation
import SwiftData
import Testing
@testable import YoUtera

@MainActor
@Suite("PredictionCycleViewModel tests")
struct PredictionCycleViewModelTests {
    @Test("testing load function when empty")
    func loadWhenEmpty() async {
        let storage = FakeCyclePromptStorage()
        let llm: FakeLLMManager<CyclePromptTask> = FakeLLMManager()
        let viewModel = PredictionCycleViewModel(llm: llm, cyclePromptStorage: storage)

        await viewModel.load(
            cycle: CycleModel(
                date: .distantPast,
                avgCycle: 5,
                avgPeriod: 5,
                cycleRegular: "Pretry regular",
                trackingGoal: "Avoiding pregnancy"
            ),
            cyclePredicted: nil
        )

        #expect(llm.generateCalled == 1)
        #expect(llm.cycleForm.fertileWindowStart == viewModel.result?.fertileWindowStart)
        #expect(llm.cycleForm.fertileWindowEnd == viewModel.result?.fertileWindowEnd)
        #expect(llm.cycleForm.nextPeriodDate == viewModel.result?.nextPeriodDate)
        #expect(llm.cycleForm.advise == viewModel.result?.advise)
        #expect(storage.saveCalled == 1)
    }

    @Test("testing load function when exist")
    func loadWhenExist() async {
        let storage = FakeCyclePromptStorage()
        let llm: FakeLLMManager<CyclePromptTask> = FakeLLMManager()
        let viewModel = PredictionCycleViewModel(llm: llm, cyclePromptStorage: storage)

        let cyclePredicted = CyclePredictModel(
            fertileWindowStart: "exist-date",
            fertileWindowEnd: "exist-date",
            nextPeriodDate: "exist-date",
            advise: "Existing data"
        )
        await viewModel.load(
            cycle: CycleModel(
                date: .distantPast,
                avgCycle: 5,
                avgPeriod: 5,
                cycleRegular: "Pretry regular",
                trackingGoal: "Avoiding pregnancy"
            ),
            cyclePredicted: cyclePredicted
        )

        #expect(llm.generateCalled == 0)
        #expect(cyclePredicted.fertileWindowStart == viewModel.result?.fertileWindowStart)
        #expect(cyclePredicted.fertileWindowEnd == viewModel.result?.fertileWindowEnd)
        #expect(cyclePredicted.nextPeriodDate == viewModel.result?.nextPeriodDate)
        #expect(cyclePredicted.advise == viewModel.result?.advise)
        #expect(storage.saveCalled == 0)
    }

    @Test("testing generate function")
    func generate() async {
        let storage = FakeCyclePromptStorage()
        let llm: FakeLLMManager<CyclePromptTask> = FakeLLMManager()
        let viewModel = PredictionCycleViewModel(llm: llm, cyclePromptStorage: storage)

        await viewModel.generate()
        #expect(llm.generateCalled == 1)
        #expect(llm.cycleForm.fertileWindowStart == viewModel.result?.fertileWindowStart)
        #expect(llm.cycleForm.fertileWindowEnd == viewModel.result?.fertileWindowEnd)
        #expect(llm.cycleForm.nextPeriodDate == viewModel.result?.nextPeriodDate)
        #expect(llm.cycleForm.advise == viewModel.result?.advise)
        #expect(storage.saveCalled == 1)
    }
}
