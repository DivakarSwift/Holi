//
//  UIRefreshContoller.swift
//  Holi
//
//  Created by Кирилл on 8/13/18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

extension UIRefreshControl {
    func beginRefreshingManually() {
        if let scrollView = superview as? UIScrollView, !isRefreshing {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y - frame.height), animated: true)
        }
        beginRefreshing()
    }
    
    func endRefreshingWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.endRefreshing()
        }
    }
}
