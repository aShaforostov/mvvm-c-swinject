//
//  FeedViewCoordinator.swift
//  PikabuApp
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2020 Alex Hafros. All rights reserved.
//

import UIKit
import RxSwift
import Swinject

class FeedViewCoordinator: BaseCoordinator<Void> {

    private let window: UIWindow

    // swiftlint:disable force_unwrapping
    var fullPostCoordinatorFactory: FullPostCoordinatorAssembly.Factory!

    private lazy var viewController: FeedViewController = {
        return FeedViewController(feedViewModel: self.viewModel)
    }()

    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: self.viewController)
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.barTintColor = Design.Colors.pikabuColor
        return navigationController
    }()

    // swiftlint:disable force_unwrapping
    var viewModel: FeedViewModelProtocol!

    init(window: UIWindow) {
      self.window = window
    }

    override func start() -> Observable<Void> {

        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()

        self.observeViewModelActions()

        return Observable.never()
    }

    private func observeViewModelActions() {
        self.viewModel.actionHandler
            .subscribe(onNext: { (action) in
                switch action {
                case .showActionSheet:
                    self.showSortSheet()
                    break
                case .openFullPost(let postID):
                    self.openFullPost(postID: postID)
                    break
                }
            }).disposed(by: self.disposeBag)
    }

    private func showSortSheet() {
        let alert = UIAlertController(title: L10n.chooseSort, message: nil, preferredStyle: .actionSheet)

        SortOrder.allCases.forEach { [weak self] (order) in
            alert.addAction(UIAlertAction(title: order.getName(), style: .default, handler: { [weak self] (_) in
                self?.viewModel?.reload(sortOrder: order)
            }))
        }
        self.viewController.present(alert, animated: true, completion: nil)
    }

    private func openFullPost(postID: Int) {
        let coordinator = self.fullPostCoordinatorFactory(self.navigationController, postID)

        coordinator.start()
        .subscribe()
        .disposed(by: self.disposeBag)
    }
}
