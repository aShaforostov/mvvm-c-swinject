//
//  UITableView+Extensions.swift
//  PikabuApp
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2020 Alex Hafros. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
}
