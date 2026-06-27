//
//  UteraApp.swift
//  Utera
//
//  Created by Bee Wijaya on 26/06/26.
//

import SwiftUI
import SwiftData
import NewRelic

@main
struct UteraApp: App {
    
    init() {
        let token = Bundle.main.infoDictionary?["NEWRELIC_TOKEN"] as? String ?? ""
        NewRelic.start(withApplicationToken: token)
    }
    
    var body: some Scene {
        WindowGroup {
            MainScreen()
        }
        .modelContainer(for: [CycleModel.self, NotificationModel.self])
    }
}
