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
    var loadCalled: Int = 0
    var saveCalled: Int = 0
    
    func load() throws -> CyclePredictModel? {
        loadCalled += 1
        return nil
    }

    func save(result _: CyclePromptTask) throws {
        saveCalled += 1
    }
}

class FakeCycleStorage: ICycleStorage {
    // MARK: - spy

    var saveCalled: Int = 0
    var deleteCalled: Int = 0
    var loadCalled: Int = 0
    
    func load() throws -> CycleModel? {
        loadCalled += 1
        return nil
    }

    func save(payload: CycleModel) throws {
        saveCalled += 1
    }
    
    func delete(payload: CycleModel) throws {
        deleteCalled += 1
    }
}

class FakeNotificationStorage: INotificationStorage {
    // MARK: - spy

    var saveCalled: Int = 0
    var deleteCalled: Int = 0

    func save(payload: NotificationModel) throws {
        saveCalled += 1
    }
    
    func delete(payload: NotificationModel) throws {
        deleteCalled += 1
    }
}
