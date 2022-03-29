//
//  NetworkService.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit

class NetworkService {
    static let shared = NetworkService()

    private let imageChache = NSCache<NSString, UIImage>()

    func getAlbumData(completion: @escaping (GetAlbumResult) -> Void) {
        guard let token = UserDefaultsStorage.getToken(),
              let request = RequestBuilder.getAlbumRequest(with: token) else {
            return
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: GetAlbumResult
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            guard error == nil else {
                result = .failure(.error(error!))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                result = .failure(.unknownError)
                return
            }
            guard let data = data else {
                result = .failure(.dataIsEmpty)
                return
            }
            result = ResponseHandler.handleGetAlbumResponse(response, data: data)
        }.resume()
    }

    func getImage(with imageUrl: String, completion: @escaping (GetImageResult) -> Void) {
        guard let request = RequestBuilder.getImageRequest(with: imageUrl) else {
            return
        }
        if let cacheImage = imageChache.object(forKey: imageUrl as NSString) {
            completion(.success(image: cacheImage))
        } else {
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let self = self else {
                    return
                }
                var result: GetImageResult
                defer {
                    DispatchQueue.main.async {
                        completion(result)
                    }
                }
                guard error == nil else {
                    result = .failure(.error(error!))
                    return
                }
                guard let data = data else {
                    result = .failure(.dataIsEmpty)
                    return
                }
                guard let image = UIImage(data: data) else {
                    result = .failure(.decodeDataError)
                    return
                }
                self.imageChache.setObject(image, forKey: imageUrl as NSString)
                result = .success(image: image)
            }.resume()
        }
    }
}
