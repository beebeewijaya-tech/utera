//
//  OnboardingViewModel.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI

enum OnboardingState {
    case getStarted, cycleForm, finish
}

@Observable
final class OnboardingViewModel {
    var onboardingState: OnboardingState = .getStarted
}
