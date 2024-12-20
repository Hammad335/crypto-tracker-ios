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
    @Published var stats: [StatisticModel] = []

    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
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
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] filteredCoins in
                self?.allCoins = filteredCoins
            }
            .store(in: &cancellables)

        // subscribe to market data
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] stats in
                print("returned stats: \(stats)")
                self?.stats = stats
            }.store(in: &cancellables)
    }

    private func mapGlobalMarketData(data: MarketDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = []

        guard let data = data
        else { return stats }

        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap,
                                       percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)

        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio,
        ])
        return stats
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
