//
//  String+Extensions.swift
//  Holi
//
//  Created by Кирилл on 10/19/18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

extension String {
    
    var toDate: Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.date(from: self)
    }
    
}
