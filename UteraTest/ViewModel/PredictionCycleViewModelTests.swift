//
//  PredictionCycleViewModelTests.swift
//  Utera
//
//  Created by Bee Wijaya on 28/08/26.
//

import Testing
import SwiftData
import Foundation

@testable import YoUtera

@MainActor
@Suite("PredictionCycleViewModel tests")
struct PredictionCycleViewModelTests {
    var container: ModelContainer
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: CycleModel.self, configurations: config)
    }
    
    @Test("testing load function when empty")
    func loadWhenEmpty() async throws {
        let llm: FakeLLMManager<CyclePromptTask> = FakeLLMManager()
        let viewModel = PredictionCycleViewModel(llm: llm)
        
        await viewModel.load(
            modelContext: container.mainContext,
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
    }
    
    @Test("testing load function when exist")
    func loadWhenExist() async throws {
        let llm: FakeLLMManager<CyclePromptTask> = FakeLLMManager()
        let viewModel = PredictionCycleViewModel(llm: llm)
        
        let cyclePredicted = CyclePredictModel(
            fertileWindowStart: "exist-date",
            fertileWindowEnd: "exist-date",
            nextPeriodDate: "exist-date",
            advise: "Existing data"
        )
        await viewModel.load(
            modelContext: container.mainContext,
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
    }
    
    @Test("testing generate function")
    func generate() async throws {
        let llm: FakeLLMManager<CyclePromptTask> = FakeLLMManager()
        let viewModel = PredictionCycleViewModel(llm: llm)
        
        await viewModel.generate(modelContext: container.mainContext)
        #expect(llm.generateCalled == 1)
        #expect(llm.cycleForm.fertileWindowStart == viewModel.result?.fertileWindowStart)
        #expect(llm.cycleForm.fertileWindowEnd == viewModel.result?.fertileWindowEnd)
        #expect(llm.cycleForm.nextPeriodDate == viewModel.result?.nextPeriodDate)
        #expect(llm.cycleForm.advise == viewModel.result?.advise)
    }
}
