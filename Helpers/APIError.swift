//
//  APIError.swift
//  Holi
//
//  Created by Кирилл on 11.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

fileprivate let keys = Constants.ErrorKey.self

enum APIError: Swift.Error, RawRepresentable {
    
    case error500
    case unauthorized
    case unknownError
    
    var rawValue: String {
        switch self {
        case .error500:
            return keys.error500
        case .unauthorized:
            return keys.unauthorized
        case .unknownError:
            return "Unknown error"
        }
    }
    
    typealias RawValue = String
    
    init(rawValue: String) {
        switch rawValue {
        case keys.error500:
            self = .error500
        case keys.unauthorized:
            self = .unauthorized
        default:
            self = .unknownError
        }
    }
    
    init(error: APIError) {
        switch error {
        case .error500:
            self = .error500
        case .unauthorized:
            self = .unauthorized
        case .unknownError:
            self = .unknownError
        }
    }
    
    init(statusCode: Int) {
        switch statusCode {
        case 500:
            self = .error500
        default:
            self = .error500
        }
    }
}
