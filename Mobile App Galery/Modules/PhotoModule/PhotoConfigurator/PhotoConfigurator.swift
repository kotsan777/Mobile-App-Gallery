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
        let dataSource = PhotoCollectionDataSource()
        let model = PhotoModel(presenter: presenter, dataSource: dataSource)
        let photoDelegate = PhotoCollectionDelegate(model: model)
        view.presenter = presenter
        presenter.model = model
        model.delegate = photoDelegate
    }
}
