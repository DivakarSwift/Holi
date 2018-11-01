//
//  ModuleFactoryImplementation.swift
//  Holi
//
//  Created by Кирилл on 22.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
class ModuleFactoryImplementation:
    PhotosModuleFactory
{
    
    private let networkManager = NetworkManager()

    func makePhotosOutput() -> PhotosView {
        let model = PhotosModel(dataManager: networkManager)
        let viewModel = PhotosViewModel(model: model)
        let vc = PhotosViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    func makePhotoDetailOutput(photo: PhotoProtocol) -> PhotoDetailView {
        let model = PhotoDetailModel(photo: photo, dataManager: networkManager)
        let vc = PhotoDetailController()
        vc.viewModel = model
        vc.hidesBottomBarWhenPushed = true
        return vc
    }
}
