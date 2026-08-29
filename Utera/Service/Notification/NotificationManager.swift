//
//  NotificationManager.swift
//  Utera
//
//  Created by Bee Wijaya on 28/08/26.
//

import SwiftUI
import UserNotifications

protocol INotificationManager {
    func requestNotification() async throws -> Bool
}

class NotificationManager: INotificationManager {
    func requestNotification() async throws -> Bool {
        let res = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
        return res
    }
}
