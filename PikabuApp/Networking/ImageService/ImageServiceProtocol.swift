//
//  ImageServiceProtocol.swift
//  Pikabu
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2019 Alex Hafros. All rights reserved.
//

import Foundation
import RxSwift

protocol ImageServiceProtocol {
    /// Download method
    /// - Parameter url: Image URL
    func downloadImage(url: String) -> Completable
    /// Get image from disk
    /// - Parameter name: Image filename
    func getImage(name: String) -> UIImage?
}
