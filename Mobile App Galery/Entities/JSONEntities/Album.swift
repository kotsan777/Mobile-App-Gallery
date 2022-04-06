//
//  Album.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 27.03.2022.
//

// MARK: - Album
struct Album: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let albumID: Int
    let date: Int
    let id: Int
    let ownerID: Int
    let sizes: [Size]
    let text: String
    let userID: Int
    let hasTags: Bool

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case ownerID = "owner_id"
        case userID = "user_id"
        case hasTags = "has_tags"
        case date, id, sizes, text
    }

    subscript(type: TypeEnum) -> Size? {
        var currentSize: Size?
        sizes.forEach { size in
            if size.type == type {
                currentSize = size
            }
        }
        return currentSize
    }
}

// MARK: - Size
struct Size: Codable {
    let height: Int
    let url: String
    let type: TypeEnum
    let width: Int
}

enum TypeEnum: String, Codable {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}

