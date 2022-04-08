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
        static let code = "code"
        static let isTokenActual = "isTokenActual"
        static let currentItem = "currentItem"
        static let currentPhotoData = "currentPhotoData"
        static let albumData = "albumData"
        static let currentDate = "currentDate"
    }

    static func updateToken(token: Token) {
        guard let token = try? JSONEncoder().encode(token) else {
            return
        }
        let key = UserDefaultsStorageKeys.token
        UserDefaults.standard.set(token, forKey: key)
    }

    static func getToken() -> Token? {
        guard let data = UserDefaults.standard.value(forKey: UserDefaultsStorageKeys.token) as? Data,
              let token = try? JSONDecoder().decode(Token.self, from: data)  else {
            return nil
        }
        return token
    }

    static func deleteCurrentToken() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsStorageKeys.token)
    }

    static func updateCode(code: String) {
        UserDefaults.standard.set(code, forKey: UserDefaultsStorageKeys.code)
    }

    static func getCode() -> String? {
        UserDefaults.standard.string(forKey: UserDefaultsStorageKeys.code)
    }

    static func deleteCode() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsStorageKeys.code)
    }

    static func updateIsTokenActual(with bool: Bool) {
        UserDefaults.standard.set(bool, forKey: UserDefaultsStorageKeys.isTokenActual)
    }

    static var isTokenActual: Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsStorageKeys.isTokenActual)
    }

    static func deleteIsTokenActual() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsStorageKeys.isTokenActual)
    }

    static func updateCurrentItem(item: Item) {
        guard let itemData = try? JSONEncoder().encode(item) else {
            return
        }
        UserDefaults.standard.set(itemData, forKey: UserDefaultsStorageKeys.currentItem)
    }

    static func getCurrentItem() -> Item? {
        guard let data = UserDefaults.standard.value(forKey: UserDefaultsStorageKeys.currentItem) as? Data,
              let item = try? JSONDecoder().decode(Item.self, from: data) else {
            return nil
        }
        return item
    }

    static func deleteCurrentItem() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsStorageKeys.currentItem)
    }

    static func updateCurrentDate(date: String) {
        UserDefaults.standard.set(date, forKey: UserDefaultsStorageKeys.currentDate)
    }

    static func getCurrentDate() -> String? {
        guard let date = UserDefaults.standard.string(forKey: UserDefaultsStorageKeys.currentDate) else {
            return nil
        }
        return date
    }

    static func deleteCurrentDate() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsStorageKeys.currentDate)
    }

    static func updateCurrentPhotoData(data: Data) {
        UserDefaults.standard.set(data, forKey: UserDefaultsStorageKeys.currentPhotoData)
    }

    static func getCurrentPhotoData() -> Data? {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultsStorageKeys.currentPhotoData) else {
            return nil
        }
        return data
    }

    static func deleteCurrentPhotoData() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsStorageKeys.currentPhotoData)
    }

    static func updateAlbumData(album: Album?) {
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
        UserDefaults.standard.removeObject(forKey: UserDefaultsStorageKeys.albumData)
    }
}
