//
//  Location.swift
//  Holi
//
//  Created by Кирилл on 9/27/18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

// MARK: Possition

class Possition: Codable {
    let latitude: Double?
    let longitude: Double?

    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
}

// MARK: Location

class Location: Codable {
    let city: String?
    let country: String?
    let position: Possition?

    enum CodingKeys: String, CodingKey {
        case city
        case country
        case position
    }
}
