//
//  TabbarController.swift
//  Holi
//
//  Created by Кирилл on 17.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
import UIKit

class TabbarController: UITabBarController, UITabBarControllerDelegate, TabbarView {
    
    var onAuthFlow: (() -> Void)?
    var signOutHandler: (() -> Void)?
    var onPhotosFlowSelect: ((UINavigationController) -> ())?
    var onUserFlowSelect: ((UINavigationController) -> ())?
    var onChatFlowSelect: ((UINavigationController) -> ())?
    var onViewDidLoad: ((UINavigationController) -> ())?
    
    //var secondItemImageView: UIImageView!
    var duration = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        view.backgroundColor = .white
        title = "Tab bar"
        tabBar.isTranslucent = true
        tabBar.tintColor = ColorPalette.mainColor
 
        let photosController = CustomNavigationController.controllerFromStoryboard(.main)
        photosController.navigationBar.tintColor = .black
        photosController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 1)
        
        let calendarController = CustomNavigationController.controllerFromStoryboard(.main)
        calendarController.navigationBar.tintColor = .black
        calendarController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        
        let viewcontrollerList = [photosController, calendarController]
        viewControllers = viewcontrollerList
        
        
//        let secondItemView = tabBar.subviews[1]
//        secondItemImageView = secondItemView.subviews.first as? UIImageView
//        secondItemImageView.contentMode = .center
    }
    
    private func notificationAnimation(_ itemTag: Int) {
        let tabItemView = tabBar.subviews[itemTag]
        let tabItemImageView = tabItemView.subviews.first as? UIImageView
        tabItemImageView?.contentMode = .center
        
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        impliesAnimation.values = [0.0 ,-8.0, 4.0, -4.0, 3.0, -2.0, 0.0]
        impliesAnimation.duration = duration * 2
        impliesAnimation.isRemovedOnCompletion = true
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        
        tabItemImageView?.layer.add(impliesAnimation, forKey: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.isHidden = true
        if let controller = customizableViewControllers?.first as? UINavigationController {
            onViewDidLoad?(controller)
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        notificationAnimation(item.tag)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let controller = viewControllers?[selectedIndex] as? UINavigationController else {
            return
        }
        
        
        switch selectedIndex {
        case 0:
            onPhotosFlowSelect?(controller)
        case 1:
            onChatFlowSelect?(controller)
        //case 2:
            //onMaterialsFlowSelect?(controller)
        case 2:
            onUserFlowSelect?(controller)
        default:
            break
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if viewController == tabBarController.viewControllers?[0] {
//            return true
//        }
//
//        if UserManager.shared.userUid == nil {
//            onAuthFlow?()
//            return false
//        }
        return true
    }

}

