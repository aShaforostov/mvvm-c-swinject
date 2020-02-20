//
//  ServicesAssembly.swift
//  PikabuApp
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2020 Alex Hafros. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class ServicesAssembly: Assembly {

    private let baseURL = URL(string: "http://cs.pikabu.ru/")!

    private func createSession(with resolver: Resolver) -> URLSession {
        return .shared
    }

    private func createAPIService(with resolver: Resolver) -> APIService {
        // swiftlint:disable force_unwrapping
        let session = resolver.resolve(URLSession.self)!

        return APIService(session: session, baseURL: self.baseURL)
    }

    private func createNetworkService(with resolver: Resolver) -> NetworkServiceProtocol {
        // swiftlint:disable force_unwrapping
        let apiService = resolver.resolve(APIService.self)!

        return NetworkService(apiService: apiService)
    }

    private func createImageService(with resolver: Resolver) -> ImageServiceProtocol {
        // swiftlint:disable force_unwrapping
        let session = resolver.resolve(URLSession.self)!

        return ImageService(session: session)
    }

    func assemble(container: Container) {
        container.register(URLSession.self, factory: createSession).inObjectScope(.container).inObjectScope(.container)
        container.register(APIService.self, factory: createAPIService).inObjectScope(.container)
        container.register(NetworkServiceProtocol.self, factory: createNetworkService).inObjectScope(.container)
        container.register(ImageServiceProtocol.self, factory: createImageService).inObjectScope(.container)
    }
}
