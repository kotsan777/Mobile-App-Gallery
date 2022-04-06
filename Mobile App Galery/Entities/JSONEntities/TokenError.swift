//
//  TokenError.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 06.04.2022.
//

struct TokenError: Codable {

    let error: String
    let errorDescription: String

    enum CodingKeys: String, CodingKey {
        case error
        case errorDescription = "error_description"
    }
}
