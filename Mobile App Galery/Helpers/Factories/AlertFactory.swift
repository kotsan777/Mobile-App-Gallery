//
//  AlertFactory.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 08.04.2022.
//

import UIKit

protocol AlertFactoryProtocol {
    func produce(with config: UIAlertController.Configuration) -> UIAlertController
}

class AlertFactory: AlertFactoryProtocol {

    func produce(with config: UIAlertController.Configuration) -> UIAlertController {
        switch config {
        case .unknownError:
            return UIAlertController(config: .unknownError)
        case .error(let error):
            return UIAlertController(config: .error(error))
        case .designatedError(let designatedError):
            return UIAlertController(config: .designatedError(designatedError))
        case .userNotSignedIn:
            return UIAlertController(config: .userNotSignedIn)
        case .saveImageSuccess:
            return UIAlertController(config: .saveImageSuccess)
        case .saveImageFailed:
            return UIAlertController(config: .saveImageFailed)
        case .tokenError(let tokenError):
            return UIAlertController(config: .tokenError(tokenError))
        }
    }
}
