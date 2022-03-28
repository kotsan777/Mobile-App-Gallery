//
//  UIBarButtonItemExtension.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 28.03.2022.
//

import UIKit

extension UIBarButtonItem {

    enum BarButtonConfiguration {
        case exitFromGallery
        case defaultBackButtonItem
    }

    convenience init(config: BarButtonConfiguration) {
        switch config {
        case .exitFromGallery:
            self.init(title: nil, style: .plain, target: nil, action: nil)
            setupExitFromGallery()
        case .defaultBackButtonItem:
            self.init(title: nil, style: .plain, target: nil, action: nil)
        }
    }

    private func setupExitFromGallery() {
        title = NavigationButtonItemsConstants.exitGalleryText
        let attributes: [NSAttributedString.Key: Any] = [.font: NavigationButtonItemsConstants.exitGalleryFont]
        setTitleTextAttributes(attributes, for: .normal)
    }
}
