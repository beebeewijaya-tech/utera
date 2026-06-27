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
