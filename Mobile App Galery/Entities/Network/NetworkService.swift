//
//  NetworkService.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit

class NetworkService {
    static let shared = NetworkService()

    func getAccessToken(code: String, completion: @escaping (GetTokenResult) -> Void) {
        guard let request = RequestBuilder.getTokenRequest(with: code) else {
            return
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: GetTokenResult
            defer {
                completion(result)
            }

            guard error == nil else {
                result = .failure(.error(error!))
                return
            }
            guard let data = data else {
                result = .failure(.failDecodeData)
                return
            }
            do {
                let token = try JSONDecoder().decode(Token.self, from: data)
                result = .success(token: token)
            }
            catch {
                do {
                    let error = try JSONDecoder().decode(DesignatedError.self, from: data)
                    result = .failure(.specialError(error))
                }
                catch {
                    result = .failure(.unknownError)
                }
            }
        }.resume()
    }
}
