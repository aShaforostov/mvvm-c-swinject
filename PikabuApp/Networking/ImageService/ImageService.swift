//
//  ImageService.swift
//  Pikabu
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2019 Alex Hafros. All rights reserved.
//

import Foundation
import RxSwift

struct InvalidURLError: Error {}

class ImageService: ImageServiceProtocol {

    private var session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func downloadImage(url: String) -> Completable {
        Completable.create { [weak self] completable in

            guard let targetURL = URL(string: url) else {
                completable(.error(InvalidURLError()))
                return Disposables.create {}
            }

            guard self?.getImage(name: targetURL.lastPathComponent) == nil else {
                completable(.completed)
                return Disposables.create {}
            }

            let task = self?.session.dataTask(with: targetURL) { (data, response, error) in
                if let error = error {
                    completable(.error(error))
                    return
                }

                guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    completable(.completed)
                    return
                }

                // swiftlint:disable force_unwrapping
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileName = targetURL.lastPathComponent
                let fileURL = documentsDirectory.appendingPathComponent(fileName)
                if let data = image.jpegData(compressionQuality: 1.0),
                  !FileManager.default.fileExists(atPath: fileURL.path) {
                    do {
                        try data.write(to: fileURL)
                        completable(.completed)
                    } catch {
                        completable(.error(error))
                    }
                } else if FileManager.default.fileExists(atPath: fileURL.path) {
                    completable(.completed)
                }
            }

            task?.resume()

            return Disposables.create {
                task?.cancel()
            }
        }
    }

    func getImage(name: String) -> UIImage? {
        // swiftlint:disable force_unwrapping
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = name
        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        let image = UIImage(contentsOfFile: fileURL.path)

        return image
    }

}
