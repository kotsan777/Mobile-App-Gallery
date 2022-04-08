//
//  PhotoConfigurator.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 29.03.2022.
//

protocol PhotoConfiguratorProtocol {
    func configure(view: PhotoViewControllerProtocol)
}

class PhotoConfigurator: PhotoConfiguratorProtocol {
    func configure(view: PhotoViewControllerProtocol) {
        let presenter = PhotoPresenter(view: view)
        let dataSource = PhotoCollectionDataSource()
        let delegate = PhotoCollectionDelegate()
        let model = PhotoModel(presenter: presenter, dataSource: dataSource, delegate: delegate)
        view.presenter = presenter
        presenter.model = model
        delegate.model = model

        view.carouselCollectionView.dataSource = dataSource
        view.carouselCollectionView.delegate = delegate
    }
}
