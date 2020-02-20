//
//  PostPreviewCellViewModel.swift
//  PikabuApp
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2020 Alex Hafros. All rights reserved.
//

import Foundation
import RxDataSources

class PostPreviewCellModel {
    let model: PostPreviewModel
    var expanded: Bool

    init(model: PostPreviewModel, expanded: Bool = false) {
        self.model = model
        self.expanded = expanded
    }
}

extension PostPreviewCellModel: IdentifiableType {
    public typealias Identity = String

    public var identity: Identity {
        return UUID().uuidString
    }
}

extension PostPreviewCellModel: Equatable {
    static func == (lhs: PostPreviewCellModel, rhs: PostPreviewCellModel) -> Bool {
        return lhs.model.postId == rhs.model.postId
    }
}
