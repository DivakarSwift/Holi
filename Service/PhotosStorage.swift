//
//  PhotosStorage.swift
//  Holi
//
//  Created by Кирилл on 11/19/18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol PhotosStorageProtocol {
    func getAllPhotos() -> [Photo]
    func saveAllPhotos(_ photos: [Photo])
    func getPhoto(_ id: String) -> Photo?
    func savePhoto(_ photo: Photo)
    func deletePhoto(_ photo: Photo)
    func deleteAllPhotos()
    func isCollectedPhoto(_ photo: Photo) -> Bool
}

class PhotosStorage: PhotosStorageProtocol {
    
    fileprivate var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    func getAllPhotos() -> [Photo] {
        if let encoded = userDefaults.object(forKey: "photos") as? Data {
            let filters = try? PropertyListDecoder().decode([Photo].self, from: encoded)
            return filters ?? []
        }
        return []
    }
    
    func saveAllPhotos(_ photos: [Photo]) {
        let encoded = try! PropertyListEncoder().encode(photos)
        userDefaults.set(encoded, forKey: "photos")
    }
    
    func getPhoto(_ id: String) -> Photo? {
        let allPhotos = getAllPhotos()
        if let index = allPhotos.index(where: {$0.id == id}){
            return allPhotos[index]
        }
        return nil
    }
    
    func savePhoto(_ photo: Photo) {
        var allPhotos = getAllPhotos()
        if !allPhotos.contains(photo) {
            allPhotos.append(photo)
            saveAllPhotos(allPhotos)
        }
    }
    
    func deletePhoto(_ photo: Photo) {
        var allPhotos = getAllPhotos()
        if let index = allPhotos.index(of: photo) {
            allPhotos.remove(at: index)
            saveAllPhotos(allPhotos)
        }
    }
    
    func deleteAllPhotos() {
        userDefaults.removeObject(forKey: "photos")
    }
    
    func isCollectedPhoto(_ photo: Photo) -> Bool {
        return getAllPhotos().contains(photo)
    }
}
