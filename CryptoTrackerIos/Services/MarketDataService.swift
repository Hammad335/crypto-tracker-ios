//
//  MarketDataService.swift
//  CryptoTrackerIos
//
//  Created by Hamad on 20/12/2024.
//

import Combine
import Foundation

class MarketDataService {
    @Published var marketData: MarketDataModel? = nil
    var marketDataSubscription: AnyCancellable?

    init() {
        getData()
    }

    private func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }

        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] data in
                self?.marketData = data.data
                      self?.marketDataSubscription?.cancel()
                  })
    }
}
