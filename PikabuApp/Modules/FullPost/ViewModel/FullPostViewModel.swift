//
//  FullPostViewModel.swift
//  Pikabu
//
//  Created by Alexey Shaforostov on 20.02.2020
//  Copyright © 2019 Alex Hafros. All rights reserved.
//

import Foundation
import RxSwift

class FullPostViewModel: FullPostViewModelProtocol {

    private let networkService: NetworkServiceProtocol

    private let imageService: ImageServiceProtocol

    // swiftlint:disable force_unwrapping
    private var postId: Int!

    init(networkService: NetworkServiceProtocol, imageService: ImageServiceProtocol) {
        self.networkService = networkService
        self.imageService = imageService
    }

    func setPostID(postID: Int) {
        self.postId = postID
    }

    var model: Observable<PostFullModel> {
        return self.networkService
            .getDetailPost(postId: self.postId)
            .asObservable()
            .map({ $0.post })
    }

    func imageRequests(images: [String]) -> [Completable] {
        let array = images.map({ self.imageService.downloadImage(url: $0) })
        return array
    }

    func getImage(named: String) -> UIImage? {
        return self.imageService.getImage(name: named)
    }

}
