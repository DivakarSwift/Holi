//
//  LikeUnlike.swift
//  Holi
//
//  Created by Кирилл on 9/27/18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

struct LikeUnlike: Decodable {
    let photo: Photo?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case photo
        case user
    }
}
