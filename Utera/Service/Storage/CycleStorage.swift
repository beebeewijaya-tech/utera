//
//  CycleStorage.swift
//  Utera
//
//  Created by Bee Wijaya on 30/08/26.
//

import SwiftData
import SwiftUI

protocol ICycleStorage {
    func save(payload: CycleModel) throws
    func delete(payload: CycleModel) throws
    func load() throws -> CycleModel?
}

class CycleStorage: ICycleStorage {
    var context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }
    
    func load() throws -> CycleModel? {
        let predicate = FetchDescriptor<CycleModel>(sortBy: [SortDescriptor(\.createdAt)])
        let result = try context.fetch(predicate)
        return result.first
    }

    func save(payload: CycleModel) throws {
        context.insert(payload)
        try context.save()
    }
    
    func delete(payload: CycleModel) throws {
        context.delete(payload)
    }
}
