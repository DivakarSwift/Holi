//
//  ItemCoordinatorOutput.swift
//  Holi
//
//  Created by Кирилл on 17.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol PhotosCoordinatorOutput: class {
    var finishFlow: (() -> Void)? { get set }
}
