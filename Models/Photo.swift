//
//  Photo.swift
//  Holi
//
//  Created by Кирилл on 9/27/18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//


protocol PhotoProtocol {
    var id: String? { get set }
    var created: String? { get set }
    var updated: String? { get set }
    var description: String? { get set }
    var color: String? { get set }
    var likes: Int? { get set }
    var likedByUser: Bool? { get set }
    var downloads: Int? { get set }
    var views: Int? { get set }
    var width: Int? { get set }
    var height: Int? { get set }
    var user: User? { get set }
    var urls: ImageURLs? { get set }
    var location: Location? { get set }
    var exif: Exif? { get set }
    var collectionsItBelongs: [Collection]? { get set }
    var links: Links? { get set }
    var categories: [Category]? { get set }
}

class Photo: PhotoProtocol, Codable {
    var id: String?
    var created: String?
    var updated: String?
    var description: String?
    var color: String?
    var likes: Int?
    var likedByUser: Bool?
    var downloads: Int?
    var views: Int?
    var width: Int?
    var height: Int?
    var user: User?
    var urls: ImageURLs?
    var location: Location?
    var exif: Exif?
    var collectionsItBelongs: [Collection]?
    var links: Links?
    var categories: [Category]?

    enum CodingKeys: String, CodingKey {
        case id
        case created = "created_at"
        case updated = "updated_at"
        case description
        case color
        case likes
        case likedByUser = "liked_by_user"
        case downloads
        case views
        case width
        case height
        case user
        case urls
        case location
        case exif
        case collectionsItBelongs = "current_user_collections"
        case links
        case categories
    }
}

extension Photo: Equatable {
    static func ==(lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id && 
                lhs.created == rhs.created && 
                lhs.user?.id == rhs.user?.id
    }
}


