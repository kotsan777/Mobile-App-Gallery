//
//  NetworkService.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit

class NetworkService {
    static let shared = NetworkService()
    
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
}
