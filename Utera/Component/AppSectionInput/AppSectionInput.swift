//
//  AppSectionInput.swift
//  Utera
//
//  Created by Bee Wijaya on 26/06/26.
//

import SwiftUI

struct AppSectionInput<Content: View>: View {
    @ViewBuilder
    let content: Content
    
    
    var body: some View {
        HStack {
            content
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 10)
        .padding(.bottom, 12)
    }
}

#Preview {
    AppSectionInput() {
        Text("Hello")
    }
}
