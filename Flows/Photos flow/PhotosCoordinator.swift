//
//  ItemCoordinator.swift
//  Holi
//
//  Created by Кирилл on 17.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
import CoreLocation

class PhotosCoordinator: BaseCoordinator, PhotosCoordinatorOutput {
    var finishFlow: (() -> Void)?
    
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    private let factory: PhotosModuleFactory
    
    init(coordinatorFactory: CoordinatorFactory, factory: PhotosModuleFactory, router: Router) {
        self.coordinatorFactory = coordinatorFactory
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        showPhotos()
    }
    
    private func showPhotos() {
        let photosOutput = factory.makePhotosOutput()
        
        photosOutput.onPhotoSelected = {[weak self] photo in
            self?.showPhotoDetail(photo: photo)
        }
        
        router.setRootModule(photosOutput, hideBar: false)
    }
    
    private func showPhotoDetail(photo: PhotoProtocol) {
        let photoDetailOutput = factory.makePhotoDetailOutput(photo: photo)
        
        router.push(photoDetailOutput)
    }
    
}


