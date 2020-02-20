//
//  FeedViewCoordinatorAssembly.swift
//  PikabuApp
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2020 Alex Hafros. All rights reserved.
//

import Swinject

class FeedViewCoordinatorAssembly: Assembly {

    typealias Factory = (UIWindow) -> FeedViewCoordinator

    private func getFeedViewCoordinatorFactory(resolver: Resolver) -> Factory {
        let factory: Factory = { window in
            let coordinator = FeedViewCoordinator(window: window)

            let networkService = resolver.resolve(NetworkServiceProtocol.self)

            // swiftlint:disable force_unwrapping
            let viewModel = FeedViewModel(networkService: networkService!)
            coordinator.viewModel = viewModel

            let fullPostCoordinatorFactory = resolver.resolve(FullPostCoordinatorAssembly.Factory.self, name: FullPostCoordinatorAssembly.registrationName)!
            coordinator.fullPostCoordinatorFactory = fullPostCoordinatorFactory
            return coordinator
        }
        return factory
    }

    public func assemble(container: Container) {
        container.register(Factory.self, name: FeedViewCoordinatorAssembly.registrationName, factory: getFeedViewCoordinatorFactory)
    }

    /// Factory registration name, which should be used to differentiate from other registrations
    /// that have the same service and factory types.
    static var registrationName = "FeedViewCoordinatorFactory"

}
