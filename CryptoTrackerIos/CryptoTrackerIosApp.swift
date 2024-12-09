//
//  CryptoTrackerIosApp.swift
//  CryptoTrackerIos
//
//  Created by Hamad on 09/12/2024.
//

import SwiftUI

@main
struct CryptoTrackerIosApp: App {
    
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)

            }
        }
        .environmentObject(homeViewModel)
    }
}
