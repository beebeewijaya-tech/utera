//
//  AppConfig.swift
//  Utera
//
//  Created by Bee Wijaya on 02/09/26.
//

import SwiftUI

struct AppConfig {
    static func stringValue(forKey: String) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: forKey) as? String else {
            return ""
        }
        
        return value
    }
}
