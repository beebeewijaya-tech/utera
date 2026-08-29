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
    private var container: ModelContainer
    private var cycleStorage: ICycleStorage
    
    init() {
        do {
            self.container = try ModelContainer(
                for: CycleModel.self, NotificationModel.self, CyclePredictModel.self
            )
            self.cycleStorage = CycleStorage(context: self.container.mainContext)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainScreen(
                cycleStorage: cycleStorage,
            )
        }
        .modelContainer(container)
    }
}
