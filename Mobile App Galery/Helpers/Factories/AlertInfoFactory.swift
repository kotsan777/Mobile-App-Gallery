//
//  AlertConstants.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 31.03.2022.
//

import UIKit

class AlertInfoFactory {

    typealias AlertInfo = (String, String)

    static func produceAlertInfo(with config: UIAlertController.Configuration) -> AlertInfo {
        switch config {
        case .unknownError:
            return unknownErrorInfo
        case .error(let error):
            return errorInfo(error)
        case .designatedError(let error):
            return designatedErrorInfo(error)
        case .userNotSignedIn:
            return userNotSignInInfo
        case .saveImageSuccess:
            return saveImageSuccessInfo
        case .saveImageFailed:
            return saveImageFailedInfo
        case .tokenError(let error):
            return tokenErrorInfo(error)
        }
    }

    private static let errorInfo: (Error) -> AlertInfo = { error in
        let title = "Ошибка"
        let message = error.localizedDescription
        return (title, message)
    }

    private static let unknownErrorInfo: AlertInfo = {
        let title = "Неизвестная ошибка"
        let message = "Попробуйте снова"
        return (title, message)
    }()

    private static let designatedErrorInfo: (DesignatedError) -> AlertInfo = { error in
        let errorCode = error.error.errorCode
        let title = "Код ошибки: \(errorCode)"
        let message = error.error.errorMsg
        return (title, message)
    }

    private static let userNotSignInInfo: AlertInfo = {
        let title = "Ошибка"
        let message = "Вы не авторизованы, перезайти?"
        return (title, message)
    }()

    private static let saveImageSuccessInfo: AlertInfo = {
        let title = "Успешно"
        let message = "Фотография успешно сохраненна"
        return (title, message)
    }()

    private static let saveImageFailedInfo: AlertInfo = {
        let title = "Ошибка"
        let message = "В ходе сохранения фотографии произошла ошибка. Попробуйте снова"
        return (title, message)
    }()

    private static let tokenErrorInfo: (TokenError) -> AlertInfo = { error in
        let title = error.error
        let message = error.errorDescription
        return (title, message)
    }
}
