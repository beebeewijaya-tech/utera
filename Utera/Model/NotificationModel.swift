//
//  NotificationModel.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI
import SwiftData

@Model
class NotificationModel {
    var days: Int
    
    init(days: Int) {
        self.days = days
    }
}

enum NotificationForm: String, CaseIterable {
    case three, five, seven
    
    var label: String {
        switch self {
        case .three:
            return "3"
        case .five:
            return "5"
        case .seven:
            return "7"
        }
    }
}
