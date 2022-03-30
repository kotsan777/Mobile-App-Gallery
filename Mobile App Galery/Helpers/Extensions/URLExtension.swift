//
//  URLExtension.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit

extension URL {

    enum QueryParameterType {
        static let accessToken = "access_token"
        static let expiresIn = "expires_in"
        static let userId = "user_id"
    }

    func queryValue(of queryParameterKey: String) -> String? {
        guard let fragment = fragment else {
            return nil
        }
        let fragmentDictionary = separateFragment(fragment)
        return fragmentDictionary[queryParameterKey]
    }

    private func separateFragment(_ anchor: String) -> [String: String] {
        var dict = [String: String]()
        let array = anchor.components(separatedBy: "&")
        array.forEach { keyValueString in
            let array = keyValueString.components(separatedBy: "=")
            let dictKey = array[0]
            let dictValue = array[1]
            dict[dictKey] = dictValue
        }
        return dict
    }
}
