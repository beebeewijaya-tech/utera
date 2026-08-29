//
//  FakeStorage.swift
//  Utera
//
//  Created by Bee Wijaya on 30/08/26.
//

import Testing
@testable import YoUtera

class FakeCyclePromptStorage: ICyclePromptStorage {
    // MARK: - spy

    var saveCalled: Int = 0

    func save(result _: CyclePromptTask) throws {
        saveCalled += 1
    }
}

class FakeCycleStorage: ICycleStorage {
    // MARK: - spy

    var saveCalled: Int = 0

    func save(payload _: CycleModel) throws {
        saveCalled += 1
    }
}
