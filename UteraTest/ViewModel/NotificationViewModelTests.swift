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
    var container: ModelContainer
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: NotificationModel.self, configurations: config)
    }
    
    
    @Test("requestNotification", arguments: [
        (false),
        (true)
    ])
    func requestNotificsation(permission: Bool) async throws {
        let notificationManager = FakeNotificationManager()
        let notificationViewModel = NotificationViewModel(
            notificationManager: notificationManager
        )
        notificationManager.permission = permission
        
        try await notificationViewModel.requestNotification()
        
        #expect(notificationViewModel.permission == permission)
        #expect(notificationManager.requestNotificationCalled == 1)
    }
    
    
    @Test("save notification failed")
    func saveNotificationFailed() async throws {
        let notificationViewModel = NotificationViewModel(
            notificationManager: FakeNotificationManager()
        )
        
        let notification = await notificationViewModel.saveNotification(context: container.mainContext)
        
        #expect(notificationViewModel.hasFinish == true)
        #expect(notification == false)
    }
    
    @Test("save notification success")
    func saveNotificationSuccess() async throws {
        let notificationViewModel = NotificationViewModel(
            notificationManager: FakeNotificationManager()
        )
        
        notificationViewModel.days = "5"
        let notification = await notificationViewModel.saveNotification(context: container.mainContext)
        
        #expect(notificationViewModel.hasFinish == true)
        #expect(notification == true)
    }
}
