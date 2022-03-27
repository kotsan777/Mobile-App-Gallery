//
//  ResponseHandler.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 27.03.2022.
//

import UIKit

class ResponseHandler {

    static func handleGetAlbumResponse(_ response: HTTPURLResponse, data: Data) -> GetAlbumResult {
        switch response.statusCode {
        case 200:
            do {
                let album = try JSONDecoder().decode(Album.self, from: data)
                return .success(album: album)
            }
            catch {
                return .failure(.accessToAlbumFailed)
            }
        default:
            return .failure(.unknownError)
        }
    }
}
