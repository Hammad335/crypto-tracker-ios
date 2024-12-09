//
//  HomeView.swift
//  CryptoTrackerIos
//
//  Created by Hamad on 09/12/2024.
//

import SwiftUI


struct HomeView : View {
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            // Content layer
            VStack{
                Text("Some text here")
                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    NavigationView{
        HomeView()
    }
    .navigationBarHidden(true)
}
