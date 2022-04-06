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
        components.scheme = CodeRequestConstants.scheme
        components.host = CodeRequestConstants.host
        components.path = CodeRequestConstants.path
        let params = [CodeRequestConstants.clientIdKey: CodeRequestConstants.clientIdValue,
                      CodeRequestConstants.displayKey: CodeRequestConstants.displayValue,
                      CodeRequestConstants.redirectUriKey: CodeRequestConstants.redirectUriValue,
                      CodeRequestConstants.responseTypeKey: CodeRequestConstants.responseTypeValue]
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        guard let url = components.url else {
            return nil
        }
        let request = URLRequest(url: url)
        return request
    }

    static func getAlbumRequest() -> URLRequest? {
        guard let token = UserDefaultsStorage.getToken() else {
            return nil
        }
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

    static func getTokenRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = TokenRequestConstants.scheme
        components.host = TokenRequestConstants.host
        components.path = TokenRequestConstants.path
        let params = [TokenRequestConstants.clientIdKey: TokenRequestConstants.clientIdValue,
                      TokenRequestConstants.clientSecretKey: TokenRequestConstants.clientSecretValue,
                      TokenRequestConstants.redirectUriKey: TokenRequestConstants.redirectUriValue,
                      TokenRequestConstants.codeKey: TokenRequestConstants.codeValue]
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        guard let url = components.url else {
            return nil
        }
        let request = URLRequest(url: url)
        return request
    }
}
