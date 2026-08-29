//
//  NotificationStorage.swift
//  Utera
//
//  Created by Bee Wijaya on 30/08/26.
//

import SwiftUI
import SwiftData

protocol INotificationStorage {
    func save(payload: NotificationModel) throws
    func delete(payload: NotificationModel) throws
}

class NotificationStorage: INotificationStorage {
    var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func save(payload: NotificationModel) throws {
        context.insert(payload)
        try context.save()
    }
    
    func delete(payload: NotificationModel) throws {
        context.delete(payload)
    }
}
