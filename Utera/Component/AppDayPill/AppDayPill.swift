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
    case fertile
    case period
    case peak
    
    var background: Color {
        switch self {
        case .active:
            return Color("System")
        case .inactive:
            return .clear
        case .fertile, .peak:
            return .clear
        case .period:
            return Color("PrimaryDark")
        }
    }
    
    var foreground: Color {
        switch self {
        case .active:
            return .white
        case .inactive:
            return .black
        case .fertile, .peak:
            return Color("Primary")
        case .period:
            return .white
        }
    }
    
    var border: CGFloat {
        switch self {
        case .active, .period:
            return 0
        case .inactive, .fertile:
            return 1
        case .peak:
            return 3
        }
    }
    
    var pill: CGFloat {
        switch self {
        case .active, .inactive, .period:
            return 0
        case .fertile:
            return 5
        case .peak:
            return 8
        }
    }
    
    var label: String {
        switch self {
        case .active:
            return "Today"
        case .inactive:
            return "Normal day"
        case .fertile:
            return "Fertile day"
        case .period:
            return "Period day"
        case .peak:
            return "Peak ovulation"
        }
    }
    
    var labelColor: Color {
        switch self {
        case .active:
            return Color("System")
        case .inactive:
            return .black
        case .fertile, .peak:
            return Color("Primary")
        case .period:
            return Color("PrimaryDark")
        }
    }
}

struct AppDayPill: View {
    var label: String
    var style: DayStyle
    var empty: Bool = false
    
    var body: some View {
        HStack {
            if empty {
                Circle()
                    .fill(.clear)
                    .frame(width: 40, height: 40)
            } else {
                VStack {
                    ZStack {
                        Text(label)
                            .font(.system(size: 12))
                            .foregroundStyle(style.foreground)
                            .bold()
                        
                        Circle()
                            .fill(style.foreground)
                            .frame(width: style.pill, height: style.pill)
                            .padding(.top, 25)
                    }
                }
                .frame(width: 40, height: 40)
                .background(style.background)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(style.foreground, style: StrokeStyle(lineWidth: style.border))
                }
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
        AppDayPill(
            label: "4",
            style: .fertile
        )
        AppDayPill(
            label: "5",
            style: .peak
        )
    }
}
