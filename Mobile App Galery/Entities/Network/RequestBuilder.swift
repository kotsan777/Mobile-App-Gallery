//
//  RequestBuilder.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit

class RequestBuilder {

    static func getAuthRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = AuthRequestConstants.scheme
        components.host = AuthRequestConstants.host
        components.path = AuthRequestConstants.path
        let params = [AuthRequestConstants.clientIdKey: AuthRequestConstants.clientIdValue,
                      AuthRequestConstants.displayKey: AuthRequestConstants.displayValue,
                      AuthRequestConstants.redirectUriKey: AuthRequestConstants.redirectUriValue,
                      AuthRequestConstants.responseTypeKey: AuthRequestConstants.responseTypeValue]
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        guard let url = components.url else {
            return nil
        }
        let request = URLRequest(url: url)
        return request
    }

    static func getAlbumRequest(with token: Token) -> URLRequest? {
        var components = URLComponents()
        components.scheme = GetPhotoRequestConstants.scheme
        components.host = GetPhotoRequestConstants.host
        components.path = GetPhotoRequestConstants.path
        let params = [GetPhotoRequestConstants.ownerIdKey: GetPhotoRequestConstants.ownerIdValue,
                      GetPhotoRequestConstants.albumIdKey: GetPhotoRequestConstants.albumIdValue,
                      GetPhotoRequestConstants.tokenKey: token.accessToken,
                      GetPhotoRequestConstants.versionKey: GetPhotoRequestConstants.versionValue]
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        guard let url = components.url else {
            return nil
        }
        let request = URLRequest(url: url)
        return request
    }
}
