//
//  RequestBuilder.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit

class RequestBuilder {

    private enum UrlString {
        static func getTokenUrlString(with code: String) -> String {
            let urlString = "https://oauth.vk.com/access_token?client_id=8115695&client_secret=y9bXGZmLzAu2fqJS17o2&redirect_uri=https://oauth.vk.com/blank.html&code=\(code)"
            return urlString
        }
        static let authUrlString = "https://oauth.vk.com/authorize?client_id=8115695&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&response_type=code"
        static func getAlbumUrlString(with token: String) -> String {
            let urlString = "https://api.vk.com/method/photos.get?owner_id=-128666765&album_id=266276915&access_token=\(token)&v=5.131"
            return urlString
        }
    }

    static func getTokenRequest(with code: String) -> URLRequest? {
        let urlString = UrlString.getTokenUrlString(with: code)
        guard let url = URL(string: urlString) else {
            return nil
        }
        let request = URLRequest(url: url)
        return request
    }

    static func getAuthRequest() -> URLRequest? {
        let urlString = UrlString.authUrlString
        guard let URL = URL(string: urlString) else {
            return nil
        }
        let request = URLRequest(url: URL)
        return request
    }

    static func getAlbumRequest(with token: Token) -> URLRequest? {
        let urlString = UrlString.getAlbumUrlString(with: token.accessToken)
        guard let url = URL(string: urlString) else {
            return nil
        }
        let request = URLRequest(url: url)
        return request
    }

    static func getImageRequest(with imageUrl: String) -> URLRequest? {
        guard let url = URL(string: imageUrl) else {
            return nil
        }
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
}
