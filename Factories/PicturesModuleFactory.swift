//
//  ArticleModuleFactory.swift
//  Holi
//
//  Created by Кирилл on 22.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol PhotosModuleFactory {
    func makePhotosOutput() -> PhotosView
    func makePhotoDetailOutput(photo: PhotoProtocol) -> PhotoDetailView
}
