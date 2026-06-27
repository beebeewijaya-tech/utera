//
//  FertileWindow.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI

struct FertileWindow: View {
    var currentDate: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                HStack {
                    Text("Day")
                        .font(.callout)
                        .foregroundStyle(Color("TextPrimary"))
                    
                    Text(currentDate, format: .dateTime.day())
                        .font(.system(size: 44))
                        .bold()
                }
                Spacer()

                Text("Fertile Window")
                    .padding()
                    .background(Color("System").opacity(0.2))
                    .foregroundStyle(Color("System"))
                    .bold()
                    .font(.caption)
                    .clipShape(Capsule())
            }
            .padding(.bottom, 12)

            HStack {
                Circle()
                    .fill(Color("System"))
                    .frame(width: 10, height: 10)
                Text("Ovulation in 1 day")
                    .font(.default)
                    .foregroundStyle(Color("TextSecondary"))
            }
            .padding(.bottom, 12)

            HStack(alignment: .top, spacing: 16) {
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .padding(12)
                    .foregroundStyle(.white)
                    .background(Color("System"))
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text("High chance to conceive")
                        .font(.callout)
                        .bold()
                        .foregroundStyle(Color("System"))
                    
                    Text("Today through ovulation is your peak window")
                        .font(.caption)
                        .foregroundStyle(Color("System").opacity(0.8))
                        .italic()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color("System").opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.1), radius: 1)
        
    }
}
