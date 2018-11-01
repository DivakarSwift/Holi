//
//  PhotoDetailModel.swift
//  Holi
//
//  Created by Кирилл on 10/11/18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
import Nuke

protocol PhotoDetailModelProtocol: Model {
    
    var didSuccesfullySavedImage: (() -> Void)? { get set }
    
    var photoRegularUrl: URL? { get }
    var totalLikes: String? { get }
    var totalViews: String? { get }
    var totalDownloads: String? { get }
    
    func saveFullImageIntoPhotoLibrary()
}

class PhotoDetailModel: BaseModel, PhotoDetailModelProtocol {
    
    private var photo: PhotoProtocol
    var didSuccesfullySavedImage: (() -> Void)?
    
    init(photo: PhotoProtocol, dataManager: DataManagerProtocol) {
        self.photo = photo
        super.init(dataManager: dataManager)
        if let photoId = photo.id {
            getPhotoDetail(withId: photoId)
        }
    }
    
    var photoRegularUrl: URL? {
        return URL(string: photo.urls?.regular ?? "")
    }
    
    var totalLikes: String? {
        guard let likes = photo.likes else { return nil }
        return String(likes)
    }
    var totalViews: String? {
        guard let views = photo.views else { return nil }
        return String(views)
    }
    
    var totalDownloads: String? {
        guard let downloads = photo.downloads else { return nil }
        return String(downloads)
    }
    
    func saveFullImageIntoPhotoLibrary() {
        guard let imageFullURL = URL(string: photo.urls?.full ?? "") else { return }
        dataManager.getPhotoDownloadLink(id: photo.id!)
        ImagePipeline.shared.loadImage(with: imageFullURL, progress: nil) { [weak self] (imageResponce, error) in
            guard let imageResponce = imageResponce else {
                self?.handleError?(error!)
                return
            }
            UIImageWriteToSavedPhotosAlbum(imageResponce.image, self, #selector(self?.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    @objc private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            handleError?(error)
            return
        }
        didSuccesfullySavedImage?()
    }
    
    private func getPhotoDetail(withId photoiId: String) {
        dataManager.photo(id: photoiId, width: nil, height: nil, rect: nil) {[weak self] (result) in
            switch result {
            case .success(let photo):
                self?.photo = photo
                self?.didUpdate?()
            case .failure(let error):
                self?.handleError?(error)
            }
        }
    }
    
}
