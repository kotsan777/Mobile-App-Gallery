//
//  PhotoConfigurator.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 29.03.2022.
//

import UIKit

protocol PhotoConfiguratorProtocol {
    func configure(view: PhotoViewControllerProtocol)
}

class PhotoConfigurator: PhotoConfiguratorProtocol {
    func configure(view: PhotoViewControllerProtocol) {
        let presenter = PhotoPresenter(view: view)
        let model = PhotoModel(presenter: presenter)
        view.presenter = presenter
        presenter.model = model
    }
}
