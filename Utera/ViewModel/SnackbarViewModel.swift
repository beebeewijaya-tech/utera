//
//  SnackbarViewModel.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI

@Observable
final class SnackbarViewModel {
    var message: String = ""
    var isShowing: Bool = false
    var type: SnackbarStyle = .danger
    
    func showMessage(_ message: String, type: SnackbarStyle = .danger) {
        self.isShowing = false
        
        self.message = message
        withAnimation(.spring(duration: 0.3)) {
            self.isShowing = true
            self.type = type
        }
        
        Task {
            try? await Task.sleep(for: .seconds(1))
            self.isShowing = false
            self.message = ""
            self.type = .danger
        }
    }
}
