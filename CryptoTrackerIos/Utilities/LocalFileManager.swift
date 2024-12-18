//
//  LocalFileManager.swift
//  CryptoTrackerIos
//
//  Created by Hamad on 19/12/2024.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()

    private init() {}

    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getImageURL(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path())
        else { return nil }

        return UIImage(contentsOfFile: url.path())
    }

    func saveImage(image: UIImage, folderName: String, imageName: String) {
        // create dir
        createFolderIfRequired(folderName: folderName)

        // get image path
        guard
            let data = image.pngData(),
            let url = getImageURL(imageName: imageName, folderName: folderName)
        else { return }

        // save image
        do {
            try data.write(to: url)
        } catch {
            print("Error saving image \(imageName): \(error.localizedDescription)")
        }
    }

    private func createFolderIfRequired(folderName: String) {
        guard let url = getFolderURL(folderName: folderName)
        else { return }

        if !FileManager.default.fileExists(atPath: url.path()) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating directory \(folderName): \(error)")
            }
        }
    }

    private func getFolderURL(folderName: String) -> URL? {
        guard let url = FileManager.default
            .urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }

        return url.appendingPathComponent(folderName)
    }

    private func getImageURL(imageName: String, folderName: String) -> URL? {
        guard let folderUrl = getFolderURL(folderName: folderName)
        else { return nil }

        return folderUrl.appendingPathComponent(imageName + ".png")
    }
}
