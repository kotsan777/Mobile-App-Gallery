//
//  ShareViewControllerFactory.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 08.04.2022.
//

import UIKit

protocol ShareViewControllerFactoryProtocol {
    func produce() -> UIActivityViewController?
}

class ShareViewControllerFactory: ShareViewControllerFactoryProtocol {

    func produce() -> UIActivityViewController? {
        guard let currentPhotoImageData = UserDefaultsStorage.getCurrentPhotoData(),
              let image = UIImage(data: currentPhotoImageData) else {
                  return nil
        }
        let activityItem: [Any] = [image as Any]
        let vc = UIActivityViewController(activityItems: activityItem, applicationActivities: nil)
        return vc
    }
}
