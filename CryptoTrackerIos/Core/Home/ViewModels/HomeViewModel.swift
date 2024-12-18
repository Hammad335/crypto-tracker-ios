//
//  HomeViewModel.swift
//  CryptoTrackerIos
//
//  Created by Hamad on 09/12/2024.
//
import Combine
import Foundation

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText : String = ""

    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }

    func addSubscribers() {
        dataService.$allCoins
            .sink {
                [weak self] coins in
                self?.allCoins = coins
            }.store(in: &cancellables)
    }
}
