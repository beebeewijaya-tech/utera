//
//  MainScreen.swift
//  Utera
//
//  Created by Bee Wijaya on 26/06/26.
//

import SwiftUI


struct MainScreen: View {
    var body: some View {
        VStack {
            TabView {
                Tab("1", systemImage: "house.fill") {
                    
                }
                
                Tab("1", systemImage: "calendar") {
                    
                }

                
                Tab("1", systemImage: "person.fill") {
                    
                }
            }
        }
    }
}


#Preview {
    MainScreen()
}
