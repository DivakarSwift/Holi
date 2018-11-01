//
//  Category.swift
//  Holi
//
//  Created by Кирилл on 9/27/18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

struct Category: Codable {
    let id: Int?
    let title: String?
    let photoCount: Int?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case id
        case title = "exposure_time"
        case photoCount = "photo_count"
        case links
    }
}

