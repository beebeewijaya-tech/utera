//
//  AppLottie.swift
//  Utera
//
//  Created by Bee Wijaya on 01/09/26.
//

import SwiftUI
import Lottie

struct AppLottie: View {
    var animation: String
    var body: some View {
        LottieView(animation: .named(animation))
            .playing(loopMode: .loop)
    }
}

#Preview {
    AppLottie(animation: "sunny")
}
