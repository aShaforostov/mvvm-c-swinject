//
//  PostsPreviewResponse.swift
//  Pikabu
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2019 Alex Hafros. All rights reserved.
//

import Foundation

struct PostsPreviewResponse: Codable {
    let posts: PostsPreview

    enum CodingKeys: String, CodingKey {
      case posts = "posts"
    }
}
