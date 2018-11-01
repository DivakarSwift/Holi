//
//  PhotoCellModel.swift
//  Holi
//
//  Created by Кирилл on 10/19/18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol PhotoCellModelOutput {
    var photoStream: PhotoProtocol { get }
    var userProfileImage: URL? { get }
    var smallPhoto: URL? { get }
    var regularPhoto: URL? { get }
    var fullname: String { get }
    var username: String { get }
    var updated: String { get }
    var photoSizeCoef: Double { get }
    var totalLikes: String { get }
    var likedByUser: Bool { get }
    var isDownloaded: Bool { get set }
}

class PhotoCellModel: PhotoCellModelOutput {
    
    var photoStream: PhotoProtocol
    private var _isDowloaded: Bool = false
    
    init(photo: PhotoProtocol) {
        self.photoStream = photo
    }
    
    var userProfileImage: URL? {
        return URL(string: photoStream.user?.profileImage?.medium ?? "")
    }
    
    var fullname: String {
        return photoStream.user?.fullName ?? ""
    }
    
    var username: String {
        return "@\(photoStream.user?.username ?? "")"
    }
    
    var smallPhoto: URL? {
        return URL(string: photoStream.urls?.small ?? "")
    }
    
    var updated: String {
        guard let date = photoStream.updated?.toDate else { return "" }
        return date.abbreviated
    }
    
    var regularPhoto: URL? {
        return URL(string: photoStream.urls?.regular ?? "")
    }
    
    var photoSizeCoef: Double {
        let width = Double(photoStream.width ?? 0)
        let height = Double(photoStream.height ?? 0)
        return Double(height * Double(UIScreen.main.bounds.width) / width)
    }
    
    var totalLikes: String {
        let likes = photoStream.likes ?? 0
        guard likes != 0 else { return ""}
        return likes.abbreviated
    }
    
    var likedByUser: Bool {
        return photoStream.likedByUser ?? false
    }
    
    var isDownloaded: Bool {
        get { return _isDowloaded }
        set(newValue) {
            _isDowloaded = newValue
        }
    }
    
}
