//
//  Storage.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit

class UserDefaultsStorage {

    enum UserDefaultsStorageKeys {
        static let token = "token"
        static let isTokenActual = "isTokenActual"
    }

    static func saveToken(token: Token) {
        let value: Any = [token.userID ,token.accessToken, token.expiresIn]
        let key = UserDefaultsStorageKeys.token
        UserDefaults.standard.set(value, forKey: key)
    }

    static func getToken() -> Token? {
        guard let value = UserDefaults.standard.array(forKey: UserDefaultsStorageKeys.token),
              let userId = value[0] as? Int,
              let accessToken = value[1] as? String,
              let expiresIn = value[2] as? Int else {
            return nil
        }
        let token = Token(accessToken: accessToken, expiresIn: expiresIn, userID: userId)
        return token
    }

    static func setIsTokenActual(with bool: Bool) {
        UserDefaults.standard.set(bool, forKey: UserDefaultsStorageKeys.isTokenActual)
    }

    static var isTokenActual: Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsStorageKeys.isTokenActual)
    }
}
