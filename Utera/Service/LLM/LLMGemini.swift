//
//  LLMGemini.swift
//  Utera
//
//  Created by Bee Wijaya on 01/09/26.
//

import SwiftUI

class LLMGemini: ILLMManager {
    var service: (any INetworkManager<PromptNetworkResponse, PromptModel>)?
    
    init() {
        guard service == nil else { return }
        service = NetworkManager(host: "https://\(AppConfig.stringValue(forKey: "API_HOST"))")
    }
    
    func generate(prompt: String) async throws -> CyclePromptTask? {
        guard let service = service else { return nil }
        
        let promptBody = PromptModel(prompt: prompt)
        let res = try await service.post(path: "/prompt", body: promptBody)
        return CyclePromptTask(
            fertileWindowStart: res.data.fertileWindowStart,
            fertileWindowEnd: res.data.fertileWindowEnd,
            nextPeriodDate: res.data.nextPeriodDate,
            advise: res.data.advise
        )
    }
}
