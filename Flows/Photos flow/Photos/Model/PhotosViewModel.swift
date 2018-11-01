//
//  
//  Holi
//
//  Created by Кирилл on 31.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol PhotosViewModelProtocol: ViewModel  {
    var itemsCount: Int { get }
    var topRoundedViewRadius: CGFloat { get }
    var selectOrderByIndex: Int { get }
    func setSelectedOrderBy(_ index: Int)
    func item(at index: Int) -> PhotoCellModelOutput
    func reloadPhotos()
    func loadMorePhotos()
}

class PhotosViewModel: BaseViewModel, PhotosViewModelProtocol {

    var model: PhotosModelProtocol
    private var photoCellModels: [PhotoCellModelOutput] = []
    
    init(model: PhotosModelProtocol){
        self.model = model
        super.init()
        bindModel()
    }
    
    override func bindModel() {
        model.didUpdate = {[weak self] in
            self?.setupPhotoCellModels()
            //self?.didUpdate?()
        }
        
        model.handleError = {[weak self] error in
            self?.handleError?(error)
        }
    }
    
    private func setupPhotoCellModels() {
        photoCellModels.removeAll()
        model.photos.forEach { photoCellModels.append(PhotoCellModel(photo: $0))}
        didUpdate?()
    }
    
    override var navigationTitle: String? {
        return "HOLI"
    }
    
    var itemsCount: Int {
        //return model.itemsCount
        return photoCellModels.count
    }
    
    var topRoundedViewRadius: CGFloat {
        return 10
    }
    
    var selectOrderByIndex: Int {
        return model.selectedOrderBy.rawValue
    }
    
    func setSelectedOrderBy(_ index: Int) {
        let orderBy = OrderBy(rawValue: index)
        model.setSelectedOrderBy(orderBy ?? OrderBy.latest)
    }
    
    func item(at index: Int) -> PhotoCellModelOutput {
        //let photo = model.item(at: index)
        //return PhotoCellModel(photo: photo)
        return photoCellModels[index]
    }
    
    func reloadPhotos() {
        model.reloadPhotos()
    }
    
    func loadMorePhotos() {
        model.loadMorePhotos()
    }
    
}
