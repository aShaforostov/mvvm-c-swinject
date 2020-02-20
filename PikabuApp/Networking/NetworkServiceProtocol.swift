//
//  NetworkServiceProtocol.swift
//  Pikabu
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2019 Alex Hafros. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkServiceProtocol {
    /// Get feed
    func getFeed() -> Single<PostsPreviewResponse>
    /// Get post by ID
    /// - Parameter postId: Post ID
    func getDetailPost(postId: Int) -> Single<PostFullResponse>
}
