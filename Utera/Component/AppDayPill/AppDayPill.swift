//
//  AppDayPill.swift
//  Utera
//
//  Created by Bee Wijaya on 28/08/26.
//

import SwiftUI

enum DayStyle {
    case active
    case inactive
    case period
    
    var background: Color {
        switch self {
        case .active:
            return Color("System")
        case .inactive:
            return .clear
        case .period:
            return .clear
        }
    }
    
    var foreground: Color {
        switch self {
        case .active:
            return .white
        case .inactive:
            return .black
        case .period:
            return .black
        }
    }
    
    var border: CGFloat {
        switch self {
        case .active:
            return 0
        case .inactive, .period:
            return 1
        }
    }
    
    var pill: CGFloat {
        switch self {
        case .active, .inactive:
            return 0
        case .period:
            return 5
        }
    }
}

struct AppDayPill: View {
    var label: String
    var style: DayStyle
    
    var body: some View {
        HStack {
            VStack {
                ZStack {
                    Text(label)
                        .font(.callout)
                        .foregroundStyle(style.foreground)
                        .bold()
                    
                    Circle()
                        .fill(Color("Primary"))
                        .frame(width: style.pill, height: style.pill)
                        .padding(.top, 25)
                }
            }
            .padding(20)
            .background(style.background)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: style.border))
            }
        }
    }
}

#Preview {
    HStack {
        AppDayPill(
            label: "1",
            style: .active
        )
        AppDayPill(
            label: "2",
            style: .inactive
        )
        AppDayPill(
            label: "3",
            style: .period
        )
    }
}
