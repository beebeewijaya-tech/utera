//
//  LogTime.swift
//  Utera
//
//  Created by Bee Wijaya on 01/09/26.
//

import Foundation

enum LogTime {
    static let start = ContinuousClock.now
    
    static func mark(_ label: String) {
        print("time: \(label) called at \(start.duration(to: .now))")
    }
}
