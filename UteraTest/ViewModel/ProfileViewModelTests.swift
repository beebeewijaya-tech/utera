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
    @Test("load empty")
    func loadEmpty() {
        let cycleStorage = FakeCycleStorage()
        let notificationStorage = FakeNotificationStorage()
        let viewModel = ProfileViewModel(
            cycleStorage: cycleStorage,
            notificationStorage: notificationStorage
        )
        
        viewModel.load(cycle: nil, notification: nil)
        
        #expect(viewModel.avgPeriod == 0)
        #expect(viewModel.avgCycle == 0)
        #expect(viewModel.selectedCycleRegular == "")
        #expect(viewModel.selectedTrackingGoal == "")
        #expect(viewModel.notificationDays == "")
    }
    
    @Test("load not empty")
    func loadNotEmpty() {
        let cycleStorage = FakeCycleStorage()
        let notificationStorage = FakeNotificationStorage()
        let viewModel = ProfileViewModel(
            cycleStorage: cycleStorage,
            notificationStorage: notificationStorage
        )
        
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
    
    @Test("test save")
    func save() throws {
        let cycleStorage = FakeCycleStorage()
        let notificationStorage = FakeNotificationStorage()
        let viewModel = ProfileViewModel(
            cycleStorage: cycleStorage,
            notificationStorage: notificationStorage
        )
        let cycle = CycleModel(
            date: .now,
            avgCycle: 5,
            avgPeriod: 5,
            cycleRegular: "Pretty regular",
            trackingGoal: "General tracking",
            
        )
        let notification = NotificationModel(days: 5)

        viewModel.save(cycle: cycle, notification: notification)
        
        #expect(viewModel.state == .success)
        #expect(notificationStorage.saveCalled == 1)
        #expect(notificationStorage.deleteCalled == 1)
        #expect(cycleStorage.saveCalled == 1)
        #expect(cycleStorage.deleteCalled == 1)
    }
}
