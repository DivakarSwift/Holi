//
//  
//  Holi
//
//  Created by Кирилл on 31.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol PhotosModelProtocol: Model {
    var photos: [PhotoProtocol] { get }
    var itemsCount: Int { get }
    var selectedOrderBy: OrderBy { get }
    func setSelectedOrderBy(_ orderBy: OrderBy)
    func item(at index: Int) -> PhotoProtocol
    func reloadPhotos()
    func loadMorePhotos()
}

class PhotosModel: BaseModel, PhotosModelProtocol {
    
    var photos: [PhotoProtocol] {
        didSet {
            didUpdate?()
        }
    }
    
    var currentPageNumber: Int = 1
    var selectedOrderBy: OrderBy = OrderBy.latest
    
    override init(dataManager: DataManagerProtocol) {
        self.photos = []
        super.init(dataManager: dataManager)
        firstRequest(currentPageNumber: currentPageNumber)
    }
    
    var itemsCount: Int {
        return photos.count
    }
    
    func item(at index: Int) -> PhotoProtocol {
        return photos[index]
    }
    
    func setSelectedOrderBy(_ orderBy: OrderBy) {
        selectedOrderBy = orderBy
    }
    
    private func firstRequest(currentPageNumber: Int) {
        getPhotos(currentPageNumber: currentPageNumber) { [weak self] photos in
            self?.photos = photos
        }
        self.currentPageNumber = 1
    }
    
    func reloadPhotos() {
        getPhotos(currentPageNumber: 1) { [weak self] photos in
            self?.photos = photos
        }
    }
    
    func loadMorePhotos() {
        currentPageNumber += 1
        getPhotos(currentPageNumber: currentPageNumber) { [weak self] photos in
            self?.photos.append(contentsOf: photos)
        }
    }
    
    private func getPhotos(currentPageNumber: Int, completion: (([Photo]) -> Void)?) {
        dataManager.photos(byPageNumber: currentPageNumber, orderBy: selectedOrderBy, curated: false) { [weak self] (result) in
            switch result {
            case .success(let photos):
                completion?(photos)
            case .failure(let error):
                self?.handleError?(error)
            }
        }
    }
}
