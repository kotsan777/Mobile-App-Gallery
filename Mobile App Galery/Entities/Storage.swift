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
        static let currentPhotoData = "currentPhotoData"
        static let currentPhotoDate = "currentPhotoDate"
        static let albumData = "albumData"
    }

    static func saveToken(token: Token) {
        let value: Any = [token.userID ,token.accessToken, token.expiresIn]
        let key = UserDefaultsStorageKeys.token
        UserDefaults.standard.set(value, forKey: key)
    }

    static func deleteCurrentToken() {
        let key = UserDefaultsStorageKeys.token
        UserDefaults.standard.set(nil, forKey: key)
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

    static func saveCurrentPhoto(item: Item, data: Data) {
        UserDefaults.standard.set(data, forKey: UserDefaultsStorageKeys.currentPhotoData)
        UserDefaults.standard.set(item.date, forKey: UserDefaultsStorageKeys.currentPhotoDate)
    }

    static func getCurrentPhotoData() -> Data {
        guard let data = UserDefaults.standard.value(forKey: UserDefaultsStorageKeys.currentPhotoData) as? Data else {
            return Data()
        }
        return data
    }

    static func getCurrentPhotoDate() -> Int {
        guard let date = UserDefaults.standard.value(forKey: UserDefaultsStorageKeys.currentPhotoDate) as? Int else {
            return 0
        }
        return date
    }

    static func deleteCurrentPhotoData() {
        UserDefaults.standard.set(nil, forKey: UserDefaultsStorageKeys.currentPhotoData)
    }

    static func deleteCurrentPhotoDate() {
        UserDefaults.standard.set(nil, forKey: UserDefaultsStorageKeys.currentPhotoDate)
    }

    static func saveAlbumData(album: Album?) {
        guard let album = album, let data = try? JSONEncoder().encode(album) else {
            return
        }
        UserDefaults.standard.set(data, forKey: UserDefaultsStorageKeys.albumData)
    }

    static func getAlbum() -> Album? {
        guard let data = UserDefaults.standard.value(forKey: UserDefaultsStorageKeys.albumData) as? Data,
              let album = try? JSONDecoder().decode(Album.self, from: data) else {
            return nil
        }
        return album
    }

    static func deleteAlbum() {
        UserDefaults.standard.set(nil, forKey: UserDefaultsStorageKeys.albumData)
    }
}
