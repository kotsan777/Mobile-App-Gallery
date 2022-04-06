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
        guard let request = RequestBuilder.getAlbumRequest() else {
            return
        }
        URLSession.shared.dataTask(with: request) { data, _, error in
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
            guard let data = data else {
                result = .failure(.unknownError)
                return
            }
            result = ResponseHandler.handleGetAlbumResponse(data: data)
        }.resume()
    }

    func getToken(completion: @escaping (GetTokenResult) -> Void) {
        guard let request = RequestBuilder.getTokenRequest() else {
            return
        }
        URLSession.shared.dataTask(with: request) { data, _, error in
            var result: GetTokenResult
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
                result = .failure(.unknownError)
                return
            }
            result = ResponseHandler.handleGetTokenResponse(data: data)
        }.resume()
    }
}
