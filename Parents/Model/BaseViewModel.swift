//
//  BaseViewModel.swift
//  Holi
//
//  Created by Кирилл on 10.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import UIKit

protocol ViewModel {
    var didUpdate: (() -> Void)? { get set }
    var handleError: ((Error) -> Void)? { get set }
    var navigationTitle: String? { get }
    func bindModel()
}

class BaseViewModel: ViewModel {
    var didUpdate: (() -> Void)?
    var handleError: ((Error) -> Void)?
    var navigationTitle: String? {
        return nil
    }
    func bindModel() {}
}
