//
//  AppSnackbar.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI

enum SnackbarStyle {
    case danger, success
    
    var background: Color {
        switch self {
        case .danger:
            return .red
        case .success:
            return .success
        }
    }
    
    var foreground: Color {
        switch self {
        case .danger, .success:
            return .white
        }
    }
}


struct AppSnackbar: View {
    var message: String
    var style: SnackbarStyle
    
    // MARK: - ViewModel
    @Environment(SnackbarViewModel.self) private var snackbarVM

    
    var body: some View {
        HStack {
            Text(message)
                .font(.callout)
                .foregroundStyle(style.foreground)
            
            Spacer()
            
            Image(systemName: "xmark")
                .font(.callout)
                .foregroundStyle(style.foreground)
                .onTapGesture {
                    snackbarVM.isShowing = false
                }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(style.background)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: .black.opacity(0.15), radius: 10)
        .padding(.horizontal, 20)
    }
}


struct SnackbarModifier: ViewModifier {
    @Environment(SnackbarViewModel.self) private var snackbarVM
    
    func body(content: Content) -> some View {
        content.overlay(alignment: .bottom) {
            if snackbarVM.isShowing {
                AppSnackbar(message: snackbarVM.message, style: snackbarVM.type)
            }
        }
    }
}

extension View {
    func snackbar() -> some View {
        modifier(SnackbarModifier())
    }
}


#Preview {
    AppSnackbar(message: "Error when fetching something", style: .danger)
        .environment(SnackbarViewModel())
}
