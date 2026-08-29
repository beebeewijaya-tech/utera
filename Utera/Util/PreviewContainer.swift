//
//  PreviewContainer.swift
//  Utera
//
//  Created by Bee Wijaya on 30/08/26.
//

import SwiftData

// PreviewContainer will be the container for every preview
enum PreviewContainer {
    static var shared: ModelContainer = {
        let container = try! ModelContainer(for: CycleModel.self, NotificationModel.self, CyclePredictModel.self)
        
        return container
    }()
}
