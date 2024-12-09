//
//  HomeViewModel.swift
//  CryptoTrackerIos
//
//  Created by Hamad on 09/12/2024.
//
import Foundation

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var isLoading: Bool = true
    
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portfolioCoins.append(DeveloperPreview.instance.coin)
            self.isLoading = false
        }
    }
    
    func doThis() {}
}
