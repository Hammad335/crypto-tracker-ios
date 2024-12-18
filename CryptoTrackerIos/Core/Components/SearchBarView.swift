//
//  SearchBarView.swift
//  CryptoTrackerIos
//
//  Created by Hamad on 19/12/2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    text.isEmpty ? Color.theme.secondaryText
                        : Color.theme.accent
                )
            TextField("Search by name or symbol...",
                      text: $text)

                .foregroundColor(Color.theme.accent)
                .disableAutocorrection(true)
                .overlay(alignment: .trailing,
                         content: {
                             Image(systemName: "xmark.circle.fill")
                                 .padding(10)
                                 .offset(x: 8)
                                 .foregroundColor(Color.theme.accent)
                                 .opacity(text.isEmpty ? 0 : 1)
                                 .animation(.easeIn, value: UUID())
                                 .onTapGesture {
                                     UIApplication.shared.endEditing()
                                     text = ""
                                 }
                         })
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.2),
                        radius: 10,
                        x: 0, y: 0)
        )
        .padding()
    }
}

#Preview {
    SearchBarView(text: .constant(""))
}
