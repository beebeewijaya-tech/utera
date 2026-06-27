//
//  UteraApp.swift
//  Utera
//
//  Created by Bee Wijaya on 26/06/26.
//

import SwiftUI
import SwiftData

@main
struct UteraApp: App {
    var body: some Scene {
        WindowGroup {
            MainScreen()
        }
        .modelContainer(for: [CycleModel.self, NotificationModel.self])
    }
}
