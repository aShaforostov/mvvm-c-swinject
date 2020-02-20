//
//  PostFullModel.swift
//  Pikabu
//
//  Created by Alexey Shaforostov on 20.02.2020
//  Copyright © 2019 Alex Hafros. All rights reserved.
//

import Foundation

public struct PostFullModel: Codable {

    let postId: Int
    let timeshamp: Int?
    let title: String?
    let text: String?
    let images: [String]?
    let likes_count: Int?

    enum CodingKeys: String, CodingKey {
        case postId = "postId"
        case timeshamp = "timeshamp"
        case title = "title"
        case text = "text"
        case images = "images"
        case likes_count = "likes_count"
    }
}
