//
//  UIExtension.swift
//  CryptoTrackerIos
//
//  Created by Hamad on 19/12/2024.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
