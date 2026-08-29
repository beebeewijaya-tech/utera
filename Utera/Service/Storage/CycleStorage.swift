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
}

class CycleStorage: ICycleStorage {
    var context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func save(payload: CycleModel) throws {
        context.insert(payload)
        try context.save()
    }
}
