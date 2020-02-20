//
//  AppCoordinatorAssembly.swift
//  PikabuApp
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2020 Alex Hafros. All rights reserved.
//

import Swinject

class AppCoordinatorAssembly: Assembly {

    typealias Factory = (UIWindow) -> AppCoordinator

    private func getAppCoordinatorFactory(resolver: Resolver) -> Factory {
        let factory: Factory = { window in
            let coordinator = AppCoordinator(window: window)
            let feedViewCoordinatorFactory = resolver.resolve(FeedViewCoordinatorAssembly.Factory.self, name: FeedViewCoordinatorAssembly.registrationName)!
            coordinator.feedViewCoordinator = feedViewCoordinatorFactory(window)
            return coordinator
        }
        return factory
    }

    public func assemble(container: Container) {
        container.register(Factory.self, name: AppCoordinatorAssembly.registrationName, factory: getAppCoordinatorFactory)
    }

    /// Factory registration name, which should be used to differentiate from other registrations
    /// that have the same service and factory types.
    static var registrationName = "AppCoordinatorFactory"

}
