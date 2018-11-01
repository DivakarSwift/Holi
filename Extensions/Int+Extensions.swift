//
//  Int+Extensions.swift
//  Holi
//
//  Created by Кирилл on 10/19/18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

extension Int {
    
    var abbreviated: String {
        // less than 1000, no abbreviation
        if self < 1000 {
            return "\(self)"
        }
        
        // less than 1 million, abbreviate to thousands
        if self < 1000000 {
            var n = Double(self)
            n = Double(floor(n/100)/10)
            return "\(n.description)K"
        }
        
        // more than 1 million, abbreviate to millions
        var n = Double(self)
        n = Double( floor(n/100000)/10 )
        return "\(n.description)M"
    }
}
