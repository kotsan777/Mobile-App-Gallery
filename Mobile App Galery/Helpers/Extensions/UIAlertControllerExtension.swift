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
        case failedDecodeData
        case error(_ error: Error)
        case specialError(_ error: DesignatedError)
    }

    convenience init(config: Configuration) {
        switch config {
        case .unknownError:
            self.init(title: nil, message: nil, preferredStyle: .alert)
            setupUnknownErrorAlert()
        case .failedDecodeData:
            self.init(title: nil, message: nil, preferredStyle: .alert)
            setupFailedDecodeDataAlert()
        case .error(let error):
            self.init(title: nil, message: nil, preferredStyle: .alert)
            setupErrorAlert(error: error)
        case .specialError(let error):
            self.init(title: nil, message: nil, preferredStyle: .alert)
            setupSpecialErrorAlert(error: error)
        }
    }

    private func setupUnknownErrorAlert() {
        title = "Неизвестная ошибка"
        message = "Попробуйте снова"
        let action = UIAlertAction(title: "Ок", style: .default)
        addAction(action)
    }

    private func setupFailedDecodeDataAlert() {
        title = "Ошибка преобразования данных"
        message = "Попробуйте снова"
        let action = UIAlertAction(title: "Ок", style: .default)
        addAction(action)
    }

    private func setupErrorAlert(error: Error) {
        title = "Ошибка"
        message = error.localizedDescription
        let action = UIAlertAction(title: "Ок", style: .default)
        addAction(action)
    }

    private func setupSpecialErrorAlert(error: DesignatedError) {
        title = error.error
        message = error.errorDescription
        let action = UIAlertAction(title: "Ок", style: .default)
        addAction(action)
    }
}
