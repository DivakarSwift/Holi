//
//  DataManager+Articles.swift
//  Holi
//
//  Created by Кирилл on 22.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

let networkActivityPlugin = NetworkActivityPlugin { (activityType, targetType) in
    switch activityType {
    case .began:
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    case .ended:
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

struct NetworkManager: DataManagerProtocol {
    
    fileprivate var keys: Constants.RestApi.Request.Type {
        return Constants.RestApi.Request.self
    }
    
    let provider = MoyaProvider<UnsplashProvider>(plugins: [NetworkLoggerPlugin(verbose: true), networkActivityPlugin])
    
    func photos(byPageNumber pageNumber: Int = 1, orderBy: OrderBy = OrderBy.popular, curated: Bool = false, completion: @escaping PhotosCompletion) {
        provider.request(.photos(page: pageNumber, perPage: keys.photosPerPage, orderBy: orderBy)) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    do {
                        let json = JSON(response.data)
                        let decoder = JSONDecoder()
                        let photos = try decoder.decode([Photo].self, from: response.data)
                        completion(.success(photos))
                    } catch let error {
                        debugPrint(error)
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func photo(id: String, width: Int?, height: Int?, rect: [Int]?, completion: @escaping PhotoCompletion) {
        provider.request(.photo(id: id, width: width, height: height, rect: rect)) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    do {
                        let json = JSON(response.data)
                        let decoder = JSONDecoder()
                        let photo = try decoder.decode(Photo.self, from: response.data)
                        completion(.success(photo))
                    } catch let error {
                        debugPrint(error)
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPhotoDownloadLink(id: String) {
        provider.request(.photoDownloadLink(id: id)) { (result) in
            switch result {
            case .success(let response):
                break
            case .failure(let error):
                break
            }
        }
    }
}
