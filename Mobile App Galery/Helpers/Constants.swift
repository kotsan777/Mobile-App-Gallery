//
//  Constants.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit

enum GetTokenResult {
    case success(token: Token)
    case failure(_ eror: GetTokenError)
}

enum GetTokenError: Error {
    case unknownError
    case failDecodeData
    case error(_ error: Error)
    case specialError(_ error: DesignatedError)
}
