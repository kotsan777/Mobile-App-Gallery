//
//  ResponseHandler.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 27.03.2022.
//

import UIKit

class ResponseHandler {

    static func handleGetAlbumResponse(data: Data) -> GetAlbumResult {
        do {
            let album = try JSONDecoder().decode(Album.self, from: data)
            return .success(album: album)
        }
        catch {
            guard let error = try? JSONDecoder().decode(DesignatedError.self, from: data) else {
                return .failure(.unknownError)
            }
            return .failure(.designatedError(error))
        }
    }

    static func handleGetTokenResponse(data: Data) -> GetTokenResult {
        do {
            let token = try JSONDecoder().decode(Token.self, from: data)
            return .success(token: token)
        }
        catch {
            guard let error = try? JSONDecoder().decode(TokenError.self, from: data) else {
                return .failure(.unknownError)
            }
            return .failure(.tokenError(error))
        }
    }
}
