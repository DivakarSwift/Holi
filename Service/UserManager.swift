//
//  UserManager.swift
//  Holi
//
//  Created by Кирилл on 19.02.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

typealias TokenCompletion = ((String?) -> Void)

final class UserManager {
    
    fileprivate init() {}
    static let shared = UserManager()
    
    fileprivate var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    fileprivate var keys: Constants.Settings.Type {
        return Constants.Settings.self
    }

    var userToken: String? {
        return userDefaults.string(forKey: keys.token)
    }
    
    var clientID: String? {
        set(newValue) {
            userDefaults.set(newValue, forKey: keys.clientID)
        }
        get {
            return userDefaults.string(forKey: keys.clientID)
        }
    }
    
    func logout() {
        userDefaults.removeObject(forKey: keys.clientID)
        userDefaults.removeObject(forKey: keys.token)
    }
}

