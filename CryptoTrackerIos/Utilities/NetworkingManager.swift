//
//  NetworkingManager.swift
//  CryptoTrackerIos
//
//  Created by Hamad on 12/12/2024.
//

import Combine
import Foundation

// reusable networking layer
class NetworkingManager {
    // Error enum
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown

        // variable on enum
        var errorDescription: String? {
            switch self {
            case .badURLResponse(let url): return "[🔥] Bad response from url : \(url)"
            case .unknown: return "[⚠️] Unknown error occured"
            }
        }
    }

    //
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
        print("Downloading...")
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { try handleURLResponse(output: $0, url: url) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200, response.statusCode < 300
        else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }

    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
}
