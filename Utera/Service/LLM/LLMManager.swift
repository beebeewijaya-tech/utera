//
//  LLMManager.swift
//  Utera
//
//  Created by Bee Wijaya on 22/08/26.
//

import SwiftUI
import FoundationModels


// LLMError is a way to describing error that happened
enum LLMError: LocalizedError {
    case modelUnavailable
    case genericError
    
    var errorDescription: String? {
        switch self {
        case .modelUnavailable:
            return "Model is not available"
        case .genericError:
            return "Something went wrong"
        }
    }
}

actor LLMManager {
    var session: FoundationModels.LanguageModelSession?

    func initialize() async throws -> LanguageModelSession? {
        if let session { return session }
        
        let model = SystemLanguageModel.default
        guard case .available = model.availability else {
            throw LLMError.modelUnavailable
        }
        
        session = LanguageModelSession()
        return session
    }
    
    func generate<T: Sendable & Generable>(prompt: String) async throws -> T? {
        let session = try await initialize()
        let res = try await session?.respond(to: prompt, generating: T.self)
        
        return res?.content
    }
}
