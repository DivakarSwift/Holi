//
//  Constants.swift
//  Holi
//
//  Created by Кирилл on 13.02.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

enum Constants {
    enum RestApi {
        enum Request {
            static let photosPerPage = 10
        }
    }
    
    enum Settings {
        static let token = "token"
        static let clientID = "clientID"
    }
    
    enum ErrorKey {
        static let error500 = "There was a problem with server, try again later"
        static let unauthorized = "Unauthorized"
    }
}

enum Constraints {
    static let defaultCellLeftRight: CGFloat = 15.0
    static let defaultCellTopBottom: CGFloat = 10.0
    static let padding: CGFloat = 8.0
    static let padding2x: CGFloat = 16.0
    static let padding3x: CGFloat = 24.0
    static let padding4x: CGFloat = 32.0
    static let cornerRadius: CGFloat = 8.0
    static let zero: CGFloat = 0.0
}
