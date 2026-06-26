//
//  MainScreen.swift
//  Utera
//
//  Created by Bee Wijaya on 26/06/26.
//

import SwiftUI


struct MainScreen: View {
    @AppStorage("onboarding") var onboarding: Bool = false
    
    
    var body: some View {
        VStack {
            if onboarding {
                TabView {
                    Tab("1", systemImage: "house.fill") {
                        
                    }
                    
                    Tab("1", systemImage: "calendar") {
                        
                    }

                    
                    Tab("1", systemImage: "person.fill") {
                        
                    }
                }
            } else {
                OnboardingScreen()
            }
        }
    }
}


#Preview {
    MainScreen()
}
