//
//  AppCounter.swift
//  Utera
//
//  Created by Bee Wijaya on 26/06/26.
//

import SwiftUI

struct AppCounter: View {
    @Binding var value: Int
    var label: String
    
    var body: some View {
        HStack {
            Text("-")
                .frame(width: 30, height: 30)
                .foregroundStyle(Color("Input"))
                .bold()
                .background(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color("Input"), lineWidth: 2)
                }
                .onTapGesture {
                    guard value > 0 else { return }
                    value -= 1
                }
            
            HStack(alignment: .center, spacing: 4) {
                Text("\(value)")
                    .font(.callout)
                    .bold()
                    .foregroundStyle(Color("TextPrimary"))
                
                
                Text("\(label)")
                    .font(.callout)
                    .foregroundStyle(Color("TextSecondary"))
            }
            .padding(.horizontal, 8)

            Text("+")
                .frame(width: 30, height: 30)
                .foregroundStyle(Color("Input"))
                .bold()
                .background(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color("Input"), lineWidth: 2)
                }
                .onTapGesture {
                    guard value < 31 else { return }
                    value += 1
                }
        }
    }
}


#Preview {
    AppCounter(value: .constant(0), label: "d")
}
