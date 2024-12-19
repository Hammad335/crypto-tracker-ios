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
    @Published var searchText: String = ""

    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }

    func addSubscribers() {
        // subscribing to dataService.allCoins publisher
        // not needed any more; because we're subscribing to this publisher combined with
        // searchText publisher below
//        dataService.$allCoins
//            .sink {
//                [weak self] coins in
//                self?.allCoins = coins
//            }.store(in: &cancellables)

        // subscribing to both publishers i.e. searchText & dataService.allCoins using combine
        // using debouncer for efficient searching
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] filteredCoins in
                self?.allCoins = filteredCoins
            }
            .store(in: &cancellables)
    }

    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else { return coins }

        let lowercassed = text.lowercased()

        return coins.filter { coin in
            coin.name.lowercased().contains(lowercassed)
                || coin.symbol.lowercased().contains(lowercassed)
                || coin.id.lowercased().contains(lowercassed)
        }
    }
}
