//
//  FakeLLMManager.swift
//  Utera
//
//  Created by Bee Wijaya on 28/08/26.
//

import Testing

@testable import YoUtera

class FakeLLMManager<T>: ILLMManager {
    // MARK: - spy
    var generateCalled: Int = 0
    
    // MARK: - stub
    var cycleForm = CyclePromptTask(
        fertileWindowStart: "test-date",
        fertileWindowEnd: "test-date",
        nextPeriodDate: "test-date",
        advise: "Hello world"
    )
    
    func generate(prompt: String) async throws -> T? {
        generateCalled += 1
        return cycleForm as? T
    }
}
