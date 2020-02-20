//
//  FeedViewModel.swift
//  PikabuApp
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2020 Alex Hafros. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

enum SortOrder: CaseIterable {
    case none
    case dateNew
    case dateOld
    case ratingBiggest
    case ratingLowest

    static var allCases: [SortOrder] = [.none, .dateNew, .dateOld, .ratingBiggest, .ratingLowest]
    
    func getName() -> String {
        switch self {
        case .none:
            return L10n.sortNone
        case .dateNew:
            return L10n.sortDateNew
        case .dateOld:
            return L10n.sortDateOld
        case .ratingBiggest:
            return L10n.sortRatingBig
        case .ratingLowest:
            return L10n.sortRatingLowest
        }
    }
}

enum FeedViewModelAction {
    case showActionSheet
    case openFullPost(Int)
}

class FeedViewModel: FeedViewModelProtocol {

    private let networkService: NetworkServiceProtocol

    private var sortOrder: SortOrder = .none

    private let actionSubject = PublishSubject<FeedViewModelAction>()

    private let reloadSubject = PublishSubject<Void>()

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    var actionHandler: Observable<FeedViewModelAction> {
        return self.actionSubject.asObservable()
    }

    var reloadHandler: Observable<Void> {
        return self.reloadSubject.asObservable()
    }

    var posts: Observable<[AnimatableSectionModel<String, PostPreviewCellModel>]> {
        return self.networkService.getFeed()
            .map({ $0.posts })
            .map { [weak self] (models) -> [PostPreviewModel] in
                guard let sortOrder = self?.sortOrder else {
                    return models
                }
                switch sortOrder {
                case .dateNew:
                    return models.sorted(by: { ($0.timeshamp ?? 0) > ($1.timeshamp ?? 0) })
                case .dateOld:
                    return models.sorted(by: { ($0.timeshamp ?? 0) < ($1.timeshamp ?? 0) })
                case .ratingBiggest:
                    return models.sorted(by: { ($0.likes_count ?? 0) > ($1.likes_count ?? 0) })
                case .ratingLowest:
                    return models.sorted(by: { ($0.likes_count ?? 0) < ($1.likes_count ?? 0) })
                case .none:
                    return models
                }
        }
        .map({ $0.map({ PostPreviewCellModel(model: $0) }) })
        .map({ [AnimatableSectionModel(model: String(describing: FeedViewModel.self), items: $0)] })
        .asObservable()
    }

    var dataSource: RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String, PostPreviewCellModel>> {
        return RxTableViewSectionedAnimatedDataSource(configureCell: { (_, tableView, indexPath, model) -> UITableViewCell in
            // swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(withIdentifier: PostPreviewTableViewCell.reuseIdentifier(), for: indexPath) as! PostPreviewTableViewCell
            cell.setup(model: model)
            _ = cell.expandCellObservable?
                .subscribe(onNext: ({
                    model.expanded = !model.expanded
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }))
            return cell
        })
    }

    func reload(sortOrder: SortOrder) {
        self.sortOrder = sortOrder
        self.reloadSubject.onNext(())
    }

    func showSortSheet() {
        self.actionSubject.onNext(.showActionSheet)
    }

    func openPost(postID: Int) {
        self.actionSubject.onNext(.openFullPost(postID))
    }
}
