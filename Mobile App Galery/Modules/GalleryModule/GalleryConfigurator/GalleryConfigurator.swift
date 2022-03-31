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
        let dataSource = GalleryCollectionDataSource()
        let prefetchDataSource = GalleryCollectionDataSourcePrefetch()
        let presenter = GalleryPresenter(view: view)
        let model = GalleryModel(presenter: presenter,
                                 dataSource: dataSource,
                                 prefetchDataSource: prefetchDataSource)
        let galleryDelegate = GalleryCollectionDelegate(model: model)
        presenter.model = model
        view.presenter = presenter
        model.delegate = galleryDelegate
    }
}
