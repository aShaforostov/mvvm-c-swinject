//
//  FullPostViewModel.swift
//  Pikabu
//
//  Created by Alexey Shaforostov on 20.02.2020
//  Copyright © 2019 Alex Hafros. All rights reserved.
//

import Foundation
import RxSwift

protocol FullPostViewModelProtocol {
    /// Set post ID
    /// - Parameter postID: Post ID
    func setPostID(postID: Int)
    /// Model
    var model: Observable<PostFullModel> { get }
    /// Generate array of Completable requests
    /// - Parameter images: Images array urls
    func imageRequests(images: [String]) -> [Completable]
    /// Get Image from disk
    /// - Parameter named: Image filename
    func getImage(named: String) -> UIImage?
}
