//
//  NotificationViewModelTests.swift
//  Utera
//
//  Created by Bee Wijaya on 28/08/26.
//

import Testing
import SwiftData

@testable import YoUtera

@MainActor
@Suite("Notification tests")
struct NotificationViewModelTests {
    @Test("requestNotification", arguments: [
        (false),
        (true)
    ])
    func requestNotificsation(permission: Bool) async throws {
        let notificationManager = FakeNotificationManager()
        let notificationStorage = FakeNotificationStorage()
        let notificationViewModel = NotificationViewModel(
            notificationManager: notificationManager,
            notificationStorage: notificationStorage
        )
        notificationManager.permission = permission
        
        try await notificationViewModel.requestNotification()
        
        #expect(notificationViewModel.permission == permission)
        #expect(notificationManager.requestNotificationCalled == 1)
    }
    
    @Test("save notification failed")
    func saveNotificationFailed() async throws {
        let notificationManager = FakeNotificationManager()
        let notificationStorage = FakeNotificationStorage()
        let notificationViewModel = NotificationViewModel(
            notificationManager: notificationManager,
            notificationStorage: notificationStorage
        )
        
        let notification = await notificationViewModel.saveNotification()
        
        #expect(notificationViewModel.hasFinish == true)
        #expect(notification == false)
        #expect(notificationStorage.saveCalled == 0)
    }
    
    @Test("save notification success")
    func saveNotificationSuccess() async throws {
        let notificationManager = FakeNotificationManager()
        let notificationStorage = FakeNotificationStorage()
        let notificationViewModel = NotificationViewModel(
            notificationManager: notificationManager,
            notificationStorage: notificationStorage
        )
        
        notificationViewModel.days = "5"
        let notification = await notificationViewModel.saveNotification()
        
        #expect(notificationViewModel.hasFinish == true)
        #expect(notification == true)
        #expect(notificationStorage.saveCalled == 1)
    }
}
