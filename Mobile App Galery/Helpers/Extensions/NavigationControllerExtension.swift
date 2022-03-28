//
//  NavigationControllerExtension.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 28.03.2022.
//

import UIKit

extension UINavigationController {

    enum NavigationControllerConfig {
        case defaultConfig
    }

    convenience init(config: NavigationControllerConfig) {
        switch config {
        case .defaultConfig:
            self.init()
            setupDefaultNavigationController()
        }
    }

    private func setupDefaultNavigationController() {
        navigationBar.tintColor = NavigationControllerConstants.tintColor
        let attributes: [NSAttributedString.Key: Any] = [.font: NavigationControllerConstants.titleFont]
        navigationBar.titleTextAttributes = attributes
    }
}
