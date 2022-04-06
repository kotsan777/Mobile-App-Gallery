//
//  NetworkConstants.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 31.03.2022.
//

enum GetPhotoRequestConstants {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let path = "/method/photos.get"
    static let ownerIdKey = "owner_id"
    static let ownerIdValue = "-128666765"
    static let albumIdKey = "album_id"
    static let albumIdValue = "266276915"
    static let tokenKey = "access_token"
    static let versionKey = "v"
    static let versionValue = "5.131"
}

enum CodeRequestConstants {
    static let scheme = "https"
    static let host = "oauth.vk.com"
    static let path = "/authorize"
    static let clientIdKey = "client_id"
    static let clientIdValue = "8115695"
    static let displayKey = "display"
    static let displayValue = "mobile"
    static let redirectUriKey = "redirect_uri"
    static let redirectUriValue = "https://oauth.vk.com/blank.html"
    static let responseTypeKey = "response_type"
    static let responseTypeValue = "code"
}

enum TokenRequestConstants {
    static let scheme = "https"
    static let host = "oauth.vk.com"
    static let path = "/access_token"
    static let clientIdKey = "client_id"
    static let clientIdValue = "8115695"
    static let clientSecretKey = "client_secret"
    static let clientSecretValue = "y9bXGZmLzAu2fqJS17o2"
    static let redirectUriKey = "redirect_uri"
    static let redirectUriValue = "https://oauth.vk.com/blank.html"
    static let codeKey = "code"
    static var codeValue: String {
        let code = UserDefaultsStorage.getCode() ?? ""
        return code
    }
}

enum GetAlbumResult {
    case success(album: Album)
    case failure(_ error: GetAlbumError)
}

enum GetAlbumError: Error {
    case unknownError
    case designatedError(_ error: DesignatedError)
    case error(_ error: Error)
    case userNotSignedIn
}

enum GetTokenResult {
    case success(token: Token)
    case failure(_ error: GetTokenError)
}

enum GetTokenError {
    case unknownError
    case tokenError(_ error: TokenError)
    case error(_ error: Error)
}

