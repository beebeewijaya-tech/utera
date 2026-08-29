//
//  CycleStorage.swift
//  Utera
//
//  Created by Bee Wijaya on 29/08/26.
//

import SwiftUI
import SwiftData

protocol ICycleStorage {
    func save(result: CyclePromptTask) throws
}

class CycleStorage: ICycleStorage {
    var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
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
