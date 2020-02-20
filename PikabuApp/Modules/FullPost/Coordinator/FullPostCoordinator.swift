//
//  FullPostCoordinator.swift
//  PikabuApp
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2020 Alex Hafros. All rights reserved.
//

import UIKit
import RxSwift

class FullPostCoordinator: BaseCoordinator<Void> {

    private let navigationController: UINavigationController

    private lazy var viewController: FullPostViewController = {
        return FullPostViewController(viewModel: self.viewModel)
    }()

    // swiftlint:disable force_unwrapping
    var viewModel: FullPostViewModelProtocol!

    init(navigationController: UINavigationController) {
      self.navigationController = navigationController
    }

    override func start() -> Observable<Void> {

        self.navigationController.pushViewController(viewController, animated: true)

        return Observable.never()
    }
}
