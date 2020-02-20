//
//  AppDelegate.swift
//  PikabuApp
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2020 Alex Hafros. All rights reserved.
//

import UIKit
import RxSwift
import Swinject

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    lazy var resolver: Swinject.Resolver = {
        var assemblies: [Assembly] = [
            ServicesAssembly()
        ]
        assemblies.append(contentsOf: ModulesAssembly.getModulesAssemblies())
        return Assembler(assemblies).resolver
    }()

    private lazy var appCoordinator: AppCoordinator = {
        // swiftlint:disable:next force_unwrapping
        let factory = resolver.resolve(AppCoordinatorAssembly.Factory.self, name: AppCoordinatorAssembly.registrationName)!
        return factory(self.window!)
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()

        _ = appCoordinator.start()
            .subscribe()

        return true
    }
}
