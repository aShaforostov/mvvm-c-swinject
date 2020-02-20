//
//  PostFullResponse.swift
//  Pikabu
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2019 Alex Hafros. All rights reserved.
//

import Foundation

struct PostFullResponse: Codable {
    let post: PostFullModel

    enum CodingKeys: String, CodingKey {
      case post = "post"
    }
}
