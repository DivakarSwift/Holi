//
//  ImageURLs.swift
//  Holi
//
//  Created by Кирилл on 9/27/18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

struct ImageURLs: Codable {
    let full: String?
    let raw: String?
    let regular: String?
    let small: String?
    let thumb: String?

    enum CodingKeys: String, CodingKey {
        case full
        case raw
        case regular
        case small
        case thumb
    }
}

