//
//  GalleryConfigurator.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 27.03.2022.
//

import UIKit

protocol GalleryConfiguratorProtocol {
    func configure(view: GalleryCollectionViewController)
}

class GalleryConfigurator: GalleryConfiguratorProtocol {
    func configure(view: GalleryCollectionViewController) {
        let presenter = GalleryPresenter(view: view)
        let model = GalleryModel(presenter: presenter)
        presenter.model = model
        view.presenter = presenter
    }
}
