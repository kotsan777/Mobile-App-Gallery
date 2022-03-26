//
//  DesignatedError.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit

struct DesignatedError: Codable {
    let error: String
    let errorDescription: String

    enum CodingKeys: String, CodingKey {
        case error
        case errorDescription = "error_description"
    }
}
