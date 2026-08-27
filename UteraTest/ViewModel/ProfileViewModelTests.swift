//
//  ProfileViewModelTests.swift
//  Utera
//
//  Created by Bee Wijaya on 27/08/26.
//

import Testing
import SwiftData
import Foundation

@testable import YoUtera


@MainActor
@Suite("Profile View Model Tests")
struct ProfileViewModelTests {
    var container: ModelContainer
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: CycleModel.self, configurations: config)
    }
    
    @Test("Testing load empty")
    func loadEmpty() {
        let viewModel = ProfileViewModel()
        
        viewModel.load(cycle: nil, notification: nil)
        
        #expect(viewModel.avgPeriod == 0)
        #expect(viewModel.avgCycle == 0)
        #expect(viewModel.selectedCycleRegular == "")
        #expect(viewModel.selectedTrackingGoal == "")
        #expect(viewModel.notificationDays == "")
    }
    
    @Test("Testing load not empty")
    func loadNotEmpty() {
        let viewModel = ProfileViewModel()
        
        let cycle = CycleModel(
            date: .now,
            avgCycle: 5,
            avgPeriod: 5,
            cycleRegular: "Pretty regular",
            trackingGoal: "General tracking",
            
        )
        
        let notification = NotificationModel(days: 5)
        
        viewModel.load(cycle: cycle, notification: notification)
        
        #expect(viewModel.avgPeriod == 5)
        #expect(viewModel.avgCycle == 5)
        #expect(viewModel.selectedCycleRegular == "Pretty regular")
        #expect(viewModel.selectedTrackingGoal == "General tracking")
        #expect(viewModel.notificationDays == "5")
    }
}
