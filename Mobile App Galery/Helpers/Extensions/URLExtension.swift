//
//  URLExtension.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit

extension URL {
    func anchorValueOf(_ queryParameterName: String) -> String? {
        let absoluteURL = self.absoluteString
        let anchor = getAnchor(absoluteURL: absoluteURL)
        let anchorDictionary = separateAnchor(anchor)
        return anchorDictionary[queryParameterName]
    }

    private func getAnchor(absoluteURL: String) -> String {
        let separatedURL = absoluteURL.components(separatedBy: "#")
        let anchor = separatedURL[separatedURL.count - 1]
        return anchor
    }

    private func separateAnchor(_ anchor: String) -> [String: String] {
        var dict = [String: String]()
        let array = anchor.components(separatedBy: "&")
        array.forEach { keyValueString in
            let array = keyValueString.components(separatedBy: "=")
            let keyValuePairsCount = array.count / 2
            for i in 0...keyValuePairsCount - 1 {
                dict[array[i]] = array[i + 1]
            }
        }
        return dict
    }
}
