//
//  HomeScreen.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI

struct HomeScreen: View {
    @State private var currentDate: Date = Date.now
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(currentDate, format: .dateTime.weekday(.wide).month(.abbreviated).day())
                        .font(.caption)
                        .foregroundStyle(Color("TextSecondary"))
                    
                    Text("Hi, Maya")
                        .font(.title)
                        .bold()
                        .foregroundStyle(Color("TextPrimary"))
                }
                
                Spacer()
                
                Image(systemName: "bell")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .font(.caption)
                    .frame(width: 25, height: 25)
                    .padding(16)
                    .background(.white)
                    .foregroundStyle(Color("Primary"))
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.1), radius:1)
            }
            .padding(.bottom, 30)
            
            WeeklyCalendar()
                .padding(.bottom, 20)
            
            FertileWindow(currentDate: currentDate)
                .padding(.bottom, 20)

            VStack {
                Text("Next period predicted Jul 29 (±2 days)")
                    .font(.caption)
                    .bold()
            }
            
            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 12)
    }
}

#Preview {
    ZStack {
        Color("Background")
            .ignoresSafeArea(.all)
        
        HomeScreen()
    }
}


