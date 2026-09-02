//
//  NotificationViewModel.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI
import UserNotifications
import SwiftData

@Observable
final class NotificationViewModel {
    var notificationManager: INotificationManager
    var days: String = ""
    var hasFinish: Bool = false
    var daysError: String? {
        guard hasFinish else { return nil }
        
        if days == "" {
            return "Please select the days"
        }
        
        return nil
    }
    var permission: Bool = false
    
    // MARK: - props
    var notificationStorage: INotificationStorage
    
    init(
        notificationManager: INotificationManager = NotificationManager(),
        notificationStorage: INotificationStorage
    ) {
        self.notificationManager = notificationManager
        self.notificationStorage = notificationStorage
    }
    
    var errors: [String] {
        [daysError].compactMap { $0 }
    }
    
    var isFormValid: Bool {
        errors.isEmpty
    }
    
    func requestNotification() async throws {
        permission = try await self.notificationManager.requestNotification()
        print("Granted \(permission)")
    }
    
    func sendNotification() {
        
    }
    
    func saveNotification() async -> Bool {
        hasFinish = true
        guard isFormValid else { return false }
        
        do {
            try await requestNotification()
            let day = Int(days) ?? 0
            let notification = NotificationModel(days: day)
            print("Notification \(notification.days)")

            try notificationStorage.save(payload: notification)
            return true
        } catch {
            print("Error when save notification \(error.localizedDescription)")
            return false
        }
    }
}
