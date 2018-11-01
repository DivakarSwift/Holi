//
//  ItemsListView.swift
//  Holi
//
//  Created by Кирилл on 17.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol PhotosView: BaseView {
    var onFinish: (() -> Void)? { get set }
    var onPhotoSelected: ((PhotoProtocol) -> Void)? { get set }
    //var onProductSelect: ((_ id: String, _ product: ProductProtocol) -> Void)? { get set}
    //var onFilterSelect: (() -> Void)? { get set }
}
