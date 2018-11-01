//
//  ProfileImage.swift
//  Holi
//
//  Created by Кирилл on 9/27/18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

struct ProfileImage: Codable {
    let small: String?
    let medium: String?
    let large: String?

    enum CodingKeys: String, CodingKey {
        case small
        case medium
        case large
    }
}
