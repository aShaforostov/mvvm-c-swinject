//
//  AppCoordinator.swift
//  PikabuApp
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2020 Alex Hafros. All rights reserved.
//

import UIKit
import RxSwift
import Swinject

class AppCoordinator: BaseCoordinator<Void> {

    private let window: UIWindow

    // swiftlint:disable force_unwrapping
    var feedViewCoordinator: FeedViewCoordinator!

    init(window: UIWindow) {
      self.window = window
    }

    override func start() -> Observable<Void> {
        return coordinate(to: self.feedViewCoordinator)
    }
}
