//
//  RequestBuilder.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit

class RequestBuilder {

    private enum URLString {
        static let getTokenURLString = "https://oauth.vk.com/access_token?client_id=8115695&client_secret=y9bXGZmLzAu2fqJS17o2&redirect_uri=https://oauth.vk.com/blank.html&code="
        static let authURLString = "https://oauth.vk.com/authorize?client_id=8115695&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&response_type=code"
    }

    static func getTokenRequest(with code: String) -> URLRequest? {
        var URLString = URLString.getTokenURLString
        URLString.append(code)
        guard let URL = URL(string: URLString) else {
            return nil
        }
        let request = URLRequest(url: URL)
        return request
    }

    static func getAuthRequest() -> URLRequest? {
        let URLString = URLString.authURLString
        guard let URL = URL(string: URLString) else {
            return nil
        }
        let request = URLRequest(url: URL)
        return request
    }
}
