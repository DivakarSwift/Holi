//
//  Exif.swift
//  Holi
//
//  Created by Кирилл on 9/27/18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

struct Exif: Codable {
    let aperture: String?
    let exposureTime: String?
    let focalLength: String?
    let iso: Int?
    let make: String?
    let model: String?

    enum CodingKeys: String, CodingKey {
        case aperture
        case exposureTime = "exposure_time"
        case focalLength = "focal_length"
        case iso
        case make
        case model
    }
}
