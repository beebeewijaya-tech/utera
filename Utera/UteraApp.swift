//
//  UteraApp.swift
//  Utera
//
//  Created by Bee Wijaya on 26/06/26.
//

import SwiftData
import SwiftUI

@main
struct UteraApp: App {
    private var container: ModelContainer
    private var cyclePromptStorage: ICyclePromptStorage
    private var cycleStorage: ICycleStorage

    init() {
        do {
            container = try ModelContainer(
                for: CycleModel.self, NotificationModel.self, CyclePredictModel.self
            )
            cyclePromptStorage = CyclePromptStorage(context: container.mainContext)
            cycleStorage = CycleStorage(context: container.mainContext)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    var body: some Scene {
        WindowGroup {
            MainScreen(
                cyclePromptStorage: cyclePromptStorage,
                cycleStorage: cycleStorage
            )
        }
        .modelContainer(container)
    }
}
