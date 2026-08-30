//
//  OnboardingViewModelTests.swift
//  Utera
//
//  Created by Bee Wijaya on 30/08/26.
//

import Testing

@testable import YoUtera

@MainActor
@Suite("Onboarding VM tests")
struct OnboardingViewModelTests {
    
    @Test("Testing set state", arguments: [
        (OnboardingState.getStarted),
        (OnboardingState.cycleForm),
        (OnboardingState.finish)
    ])
    func testSetState(arg: OnboardingState) {
        let viewModel = OnboardingViewModel()
        viewModel.setState(arg)
        
        #expect(viewModel.onboardingState == arg)
    }
}
