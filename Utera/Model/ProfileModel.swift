//
//  ProfileModel.swift
//  Utera
//
//  Created by Bee Wijaya on 02/09/26.
//

import SwiftUI

enum CycleConditionForm: String, CaseIterable {
    case regular, varies, notsure
    
    var label: String {
        switch self {
        case .regular:
            return "Pretty Regular"
        case .varies:
            return "Varies a lot"
        case .notsure:
            return "Not sure"
        }
    }
}

enum TrackingGoalForm: String, CaseIterable {
    case general, tryconceive, avoid
    
    var label: String {
        switch self {
        case .general:
            return "General tracking"
        case .tryconceive:
            return "Trying to conceive"
        case .avoid:
            return "Avoiding pregnancy"
        }
    }
}
