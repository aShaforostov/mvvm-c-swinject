//
//  FullPostCoordinatorAssembly.swift
//  PikabuApp
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2020 Alex Hafros. All rights reserved.
//

import Swinject

class FullPostCoordinatorAssembly: Assembly {

    typealias Factory = (UINavigationController, Int) -> FullPostCoordinator

    private func getFullPostCoordinatorFactory(resolver: Resolver) -> Factory {
        let factory: Factory = { navigationController, postID in
            let coordinator = FullPostCoordinator(navigationController: navigationController)
            let networkService = resolver.resolve(NetworkServiceProtocol.self)!
            let imageService = resolver.resolve(ImageServiceProtocol.self)!
            let viewModel = FullPostViewModel(networkService: networkService, imageService: imageService)
            viewModel.setPostID(postID: postID)
            coordinator.viewModel = viewModel
            return coordinator
        }
        return factory
    }

    public func assemble(container: Container) {
        container.register(Factory.self, name: FullPostCoordinatorAssembly.registrationName, factory: getFullPostCoordinatorFactory)
    }

    /// Factory registration name, which should be used to differentiate from other registrations
    /// that have the same service and factory types.
    static var registrationName = "FullPostCoordinatorFactory"

}
