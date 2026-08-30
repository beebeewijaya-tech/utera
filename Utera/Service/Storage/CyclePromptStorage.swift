//
//  CyclePromptStorage.swift
//  Utera
//
//  Created by Bee Wijaya on 29/08/26.
//

import SwiftData
import SwiftUI

protocol ICyclePromptStorage {
    func load() throws -> CyclePredictModel?
    func save(result: CyclePromptTask) throws
}

class CyclePromptStorage: ICyclePromptStorage {
    var context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }
    
    func load() throws -> CyclePredictModel? {
        let descriptor = FetchDescriptor<CyclePredictModel>(sortBy: [SortDescriptor(\.createdAt)])
        let result = try context.fetch(descriptor)        
        return result.first
    }

    func save(result: CyclePromptTask) throws {
        context.insert(
            CyclePredictModel(
                fertileWindowStart: result.fertileWindowStart,
                fertileWindowEnd: result.fertileWindowEnd,
                nextPeriodDate: result.nextPeriodDate,
                advise: result.advise
            )
        )

        try context.save()
    }
}
