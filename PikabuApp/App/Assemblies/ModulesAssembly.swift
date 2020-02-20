//
//  ModulesAssembly.swift
//  PikabuApp
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2020 Alex Hafros. All rights reserved.
//

import Swinject

class ModulesAssembly {

    class func getModulesAssemblies() -> [Assembly] {
        return [
            AppCoordinatorAssembly(),
            FeedViewCoordinatorAssembly(),
            FullPostCoordinatorAssembly()
        ]
    }
}
