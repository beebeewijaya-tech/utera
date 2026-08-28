//
//  FakeNotificationManager.swift
//  Utera
//
//  Created by Bee Wijaya on 28/08/26.
//

import Testing
import SwiftUI

@testable import YoUtera

class FakeNotificationManager: INotificationManager {
    // MARK: - stub
    var permission = false
    
    // MARK: - spy
    var requestNotificationCalled: Int = 0
    
    func requestNotification() async throws -> Bool {
        requestNotificationCalled += 1
        return permission
    }
}
