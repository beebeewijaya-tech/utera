//
//  AppPill.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI

enum AppPillStyle {
    case active, inactive
    
    var foreground: Color {
        switch self {
        case .active:
            return Color("Primary")
        case .inactive:
            return Color("TextSecondary")
        }
    }
}

struct AppPill: View {
    var label: String
    var style: AppPillStyle
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                Text(label)
                    .foregroundStyle(style.foreground)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(style.foreground, lineWidth: 1)
            }
        }
    }
}

#Preview {
    AppPill(label: "Pretty Regular", style: .active) {
        
    }
}
