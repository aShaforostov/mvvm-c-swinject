//
//  UIBarButtonItem+Extensions.swift
//  PikabuApp
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2020 Alex Hafros. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    static func menuButton(_ target: Any?, action: Selector?, image: UIImage) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        if let selector = action {
            button.addTarget(target, action: selector, for: .touchUpInside)
        }

        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true

        return menuBarItem
    }
}
