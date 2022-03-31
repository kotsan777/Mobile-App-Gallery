//
//  DesignatedError.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit

// MARK: - DesignatedError
struct DesignatedError: Codable {
    let error: VKRequestError
}

// MARK: - Error
struct VKRequestError: Codable {
    let errorCode: Int
    let errorMsg: String
    let requestParams: [RequestParam]

    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMsg = "error_msg"
        case requestParams = "request_params"
    }
}

// MARK: - RequestParam
struct RequestParam: Codable {
    let key, value: String
}
