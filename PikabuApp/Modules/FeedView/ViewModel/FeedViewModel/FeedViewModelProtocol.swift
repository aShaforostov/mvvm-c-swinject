//
//  FeedViewModelProtocol.swift
//  Pikabu
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2019 Alex Hafros. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

protocol FeedViewModelProtocol {
    /// Action Handler
    var actionHandler: Observable<FeedViewModelAction> { get }
    /// Reload Handler
    var reloadHandler: Observable<Void> { get }
    /// Models
    var posts: Observable<[AnimatableSectionModel<String, PostPreviewCellModel>]> { get }
    /// DataSource
    var dataSource: RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String, PostPreviewCellModel>> { get }

    /// Reload datasource with sort order
    /// - Parameter sortOrder: Enum
    func reload(sortOrder: SortOrder)

    /// Show Sort Action Sheet
    func showSortSheet()

    /// Open full post
    /// - Parameter postID: Post ID
    func openPost(postID: Int)
}
