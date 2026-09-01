//
//  PromptModel.swift
//  Utera
//
//  Created by Bee Wijaya on 02/09/26.
//

import SwiftUI

nonisolated struct PromptModel: Codable {
    var prompt: String
}

nonisolated struct PromptNetworkResponse: Codable {
    var data: CyclePromptTask
}
