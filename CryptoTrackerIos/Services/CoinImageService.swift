//
//  CoinImageService.swift
//  CryptoTrackerIos
//
//  Created by Hamad on 12/12/2024.
//

import Combine
import Foundation
import SwiftUI

class CoinImageService {
    private let folderName = "coin_images"

    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?

    private let coin: CoinModel
    private let imageName: String

    private let fileManager = LocalFileManager.instance

    init(coin: CoinModel) {
        self.coin = coin
        imageName = coin.id
        getCoinImageLocally()
    }

    private func getCoinImageLocally() {
        if let savedImage = fileManager.getImage(imageName: coin.id, folderName: folderName) {
            image = savedImage
            print("retrieved image from storage: id: \(imageName)")
        }
        else {
            downloadCoinImage()
            print("downloading image: id: \(coin.id)")
        }
    }

    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }

        imageSubscription = NetworkingManager.download(url: url)
            .tryMap { data -> UIImage? in
                return UIImage(data: data)
            }
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] image in
                      guard
                          let self = self,
                          let image = image
                      else { return }
                      self.image = image
                      self.imageSubscription?.cancel()
                      self.fileManager.saveImage(image: image, folderName: folderName, imageName: imageName)
                  })
    }
}
