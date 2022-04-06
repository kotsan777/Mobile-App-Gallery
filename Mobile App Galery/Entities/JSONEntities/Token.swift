//
//  Token.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

struct Token: Codable {
    let accessToken: String
    let expiresIn: Int
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case userID = "user_id"
    }
}
