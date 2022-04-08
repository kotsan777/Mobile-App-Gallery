//
//  GalleryConfigurator.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 27.03.2022.
//

protocol GalleryConfiguratorProtocol {
    func configure(view: GalleryCollectionViewController)
}

class GalleryConfigurator: GalleryConfiguratorProtocol {
    func configure(view: GalleryCollectionViewController) {
        let dataSource = GalleryCollectionDataSource()
        let prefetchDataSource = GalleryCollectionDataSourcePrefetch()
        let delegate = GalleryCollectionDelegate()

        let presenter = GalleryPresenter(view: view)
        let model = GalleryModel(presenter: presenter,
                                 dataSource: dataSource,
                                 prefetchDataSource: prefetchDataSource,
                                 delegate: delegate)

        presenter.model = model
        view.presenter = presenter
        model.dataSource = dataSource
        model.prefetchDataSource = prefetchDataSource
        delegate.model = model

        view.collectionView.dataSource = dataSource
        view.collectionView.prefetchDataSource = prefetchDataSource
        view.collectionView.delegate = delegate
    }
}
