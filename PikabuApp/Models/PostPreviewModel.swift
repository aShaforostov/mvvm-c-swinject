//
//  PostModel.swift
//  Pikabu
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2019 Alex Hafros. All rights reserved.
//

import Foundation

public typealias PostsPreview = [PostPreviewModel]

public class PostPreviewModel: Codable {
    let postId: Int
    let timeshamp: Int?
    let title: String?
    let preview_text: String?
    let likes_count: Int?

    enum CodingKeys: String, CodingKey {
        case postId = "postId"
        case timeshamp = "timeshamp"
        case title = "title"
        case preview_text = "preview_text"
        case likes_count = "likes_count"
    }
}
