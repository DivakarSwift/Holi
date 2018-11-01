//
//  UITableViewCell+Extension.swift
//  Holi
//
//  Created by Кирилл on 8/13/18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
extension UIResponder {
    
    func next<T: UIResponder>(_ type: T.Type) -> T? {
        return next as? T ?? next?.next(type)
    }
}

extension UITableViewCell {
    
    var tableView: UITableView? {
        return next(UITableView.self)
    }
    
    var indexPath: IndexPath? {
        return tableView?.indexPath(for: self)
    }
}
