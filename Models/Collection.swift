//
//  Collection.swift
//  Holi
//
//  Created by Кирилл on 9/27/18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

struct Collection: Codable {
    let id: Int?
    let coverPhoto: Photo?
    let isCurated: Bool?
    let isFeatured: Bool?
    let title: String?
    let description: String?
    let totalPhotos: Int?
    let isPrivate: Bool?
    let publishedAt: String?
    let updatedAt: String?
    let user: User?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case id
        case coverPhoto = "cover_photo"
        case isCurated = "curated"
        case isFeatured = "featured"
        case title
        case description
        case totalPhotos = "total_photos"
        case isPrivate = "private"
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
        case user
        case links
    }
}
