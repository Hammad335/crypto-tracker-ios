//
//  CircleButtonAnimationView.swift
//  CryptoTrackerIos
//
//  Created by Hamad on 09/12/2024.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding var animate: Bool

    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1 : 0)
            .opacity(animate ? 0 : 1)
            .animation(
                animate ? .easeOut(duration: 1) : .none,
                value: UUID())
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(true))
}
