//
//  TabbarCoordinator.swift
//  Holi
//
//  Created by Кирилл on 16.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
import UIKit

class TabbarCoordinator: BaseCoordinator, TabbarCoordinatorOutput {
    var finishFlow: (() -> Void)?
    var runAuthFlow: (() -> Void)?
    
    private let tabbarView: TabbarView!
    private let coordinatorFactory: CoordinatorFactory!
    private let router: Router
    
    init(tabbarView: TabbarView, coordinatorFactory: CoordinatorFactory, router: Router) {
        self.tabbarView = tabbarView
        self.coordinatorFactory = coordinatorFactory
        self.router = router
    }
    
    override func start() {
        tabbarView.onViewDidLoad = runPhotosFlow()
        tabbarView.onPhotosFlowSelect = runPhotosFlow()
        tabbarView.signOutHandler = {[weak self] in
            self?.finishFlow?()
        }
        tabbarView.onAuthFlow = {[weak self] in
            self?.runAuthFlow?()
        }
    }
    
    private func runPhotosFlow() -> ((UINavigationController) -> ()) {
        return { navController in
            if navController.viewControllers.isEmpty == true {
                let PhotosCoordinator = self.coordinatorFactory.makePhotosCoordinator(navController: navController)
                PhotosCoordinator.start()
                self.addDependency(PhotosCoordinator)
            }
        }
    }
}
