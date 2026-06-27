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
    var days: String = ""
    var hasFinish: Bool = false
    var daysError: String? {
        guard hasFinish else { return nil }
        
        if days == "" {
            return "Please select the days"
        }
        
        return nil
    }
    
    var errors: [String] {
        [daysError].compactMap { $0 }
    }
    
    var isFormValid: Bool {
        errors.isEmpty
    }
    
    func requestNotification() async throws {
        let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
        print("Granted \(granted)")
    }
    
    
    func sendNotification() {
        
    }
    
    
    func saveNotification(context: ModelContext) async -> Bool {
        hasFinish = true
        guard isFormValid else { return false }
        
        try? await requestNotification()
        
        let d = Int(days) ?? 0
        let notification = NotificationModel(days: d)
        print("Notification \(notification.days)")
        context.insert(notification)
        
        return true
    }
}
