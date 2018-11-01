//
//  NetworkManagerProtocol.swift
//  Holi
//
//  Created by Кирилл on 25.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

enum Result<Value, Error> {
    case success(Value)
    case failure(Error)
}

typealias SuccessCompletion = (Result<Bool, Error>) -> Void
typealias PhotosCompletion = (Result<[Photo], Error>) -> Void
typealias PhotoCompletion = (Result<Photo, Error>) -> Void

protocol DataManagerProtocol:
    PhotosDataManager,
    UserDataManager {}

protocol FirebaseDataManagerProtocol: AuthorizationDataManager {
}

protocol AuthorizationDataManager {
    func signIn(email: String, password: String, completion: @escaping SuccessCompletion)
    func signUp(email: String, username: String, password: String, avatarImage: UIImage, completion: @escaping SuccessCompletion)
    func signOut(completion: @escaping SuccessCompletion)
}

protocol PhotosDataManager {
    func photos(byPageNumber pageNumber: Int, orderBy: OrderBy, curated: Bool, completion: @escaping PhotosCompletion)
    func photo(id: String, width: Int?, height: Int?, rect: [Int]?, completion: @escaping PhotoCompletion)
    func getPhotoDownloadLink(id: String)
}

protocol UserDataManager {
}


