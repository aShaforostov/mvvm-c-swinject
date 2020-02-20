//
//  NetworkService.swift
//  Pikabu
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2019 Alex Hafros. All rights reserved.
//

import Foundation
import RxSwift

class NetworkService: NetworkServiceProtocol {

    private var apiService: APIService

    init(apiService: APIService) {
        self.apiService = apiService
    }

    func getFeed() -> Single<PostsPreviewResponse> {
        return self.apiService.GET(endpoint: .feed)
    }

    func getDetailPost(postId: Int) -> Single<PostFullResponse> {
        return self.apiService.GET(endpoint: .post(postID: postId))
    }
}
