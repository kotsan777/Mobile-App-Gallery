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
    }


    convenience init(config: Configuration) {
        switch config {
        case .unknownError:
            self.init(title: nil, message: nil, preferredStyle: .alert)
            setupUnknownErrorAlert()
        case .error(let error):
            self.init(title: nil, message: nil, preferredStyle: .alert)
            setupErrorAlert(error: error)
        case .saveImageSuccess:
            self.init(title: nil, message: nil, preferredStyle: .alert)
            setupSaveImageSuccessAlert()
        case .saveImageFailed:
            self.init(title: nil, message: nil, preferredStyle: .alert)
            setupSaveImageFailedAlert()
        case .designatedError(let error):
            self.init(title: nil, message: nil, preferredStyle: .alert)
            setupDesignatedError(error: error)
        case .userNotSignedIn:
            self.init(title: nil, message: nil, preferredStyle: .alert)
            setupUserNotSignedInAlert()
        }
    }

    private func setupUnknownErrorAlert() {
        title = "Неизвестная ошибка"
        message = "Попробуйте снова"
    }

    private func setupErrorAlert(error: Error) {
        title = "Ошибка"
        message = error.localizedDescription
    }

    private func setupSaveImageSuccessAlert() {
        title = "Успешно"
        message = "Фотография успешно сохраненна"
    }

    private func setupSaveImageFailedAlert() {
        title = "Ошибка"
        message = "В ходе сохранения фотографии произошла ошибка. Попробуйте снова"
    }

    private func setupDesignatedError(error: DesignatedError) {
        let code = error.error.errorCode
        let errorMessage = error.error.errorMsg
        title = "Код ошибки: \(code)"
        message = errorMessage
    }

    private func setupUserNotSignedInAlert() {
        title = "Ошибка"
        message = "Вы не авторизованы, перезайти?"
    }

    func addAction(config: UIAlertAction.AlertActionCongiuration, completion: ((UIAlertAction) -> ())?) {
        let action = UIAlertAction(config: config, completion: completion)
        addAction(action)
    }

    func addAction(config: UIAlertAction.AlertActionCongiuration) {
        addAction(config: config, completion: nil)
    }
}
