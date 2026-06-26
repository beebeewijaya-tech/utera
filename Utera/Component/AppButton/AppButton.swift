//
//  AppButton.swift
//  Utera
//
//  Created by Bee Wijaya on 26/06/26.
//

import SwiftUI

enum ButtonStyle {
    case primary, secondary
    
    
    var background: Color {
        switch self {
        case .primary:
            return Color("Primary")
        case .secondary:
            return .white
        }
    }
    
    var foreground: Color {
        switch self {
        case .primary:
            return .white
        case .secondary:
            return Color("Primary")
        }
    }
    
    
    var borderWidth: CGFloat {
        switch self {
        case .primary:
            return 0
        case .secondary:
            return 2
        }
    }
}

struct AppButton: View {
    var label: String
    var style: ButtonStyle
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                Text(label)
                    .font(.headline)
                    .foregroundStyle(style.foreground)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 64)
            .background(style.background)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(style.foreground, lineWidth: style.borderWidth)
            }
        }
    }
}


#Preview {
    AppButton(label: "Get Started", style: .primary) {
        
    }
}
