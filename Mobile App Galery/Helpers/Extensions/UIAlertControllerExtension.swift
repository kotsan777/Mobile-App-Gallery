//
//  UIAlertControllerExtension.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit

extension UIAlertController {
    
    enum Configuration {
        case unknownError
        case error(_ error: Error)
        case designatedError(_ error: DesignatedError)
        case userNotSignedIn
        case saveImageSuccess
        case saveImageFailed
        case tokenError(_ error: TokenError)
    }

    convenience init(config: Configuration) {
        self.init(title: nil, message: nil, preferredStyle: .alert)
        handleConfig(config: config)
    }

    func addAction(config: UIAlertAction.AlertActionCongiuration, completion: ((UIAlertAction) -> ())?) {
        let action = UIAlertAction(config: config, completion: completion)
        addAction(action)
    }

    func addAction(config: UIAlertAction.AlertActionCongiuration) {
        addAction(config: config, completion: nil)
    }

    private func handleConfig(config: Configuration) {
        let alertInfo = AlertInfoFactory.getAlertInfo(with: config)
        title = alertInfo.0
        message = alertInfo.1
    }
}
