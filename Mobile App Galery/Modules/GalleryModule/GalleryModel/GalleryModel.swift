//
//  GalleryModel.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 27.03.2022.
//

import UIKit
import WebKit
import SDWebImage

protocol GalleryModelProtocol: AnyObject {
    var delegate: GalleryCollectionDelegateProtocol! {get set}
    func registerCell(for collectionView: UICollectionView)
    func setupCollectionViewDelegate(for collectionView: UICollectionView)
    func setupCollectionViewDataSource(for collectionView: UICollectionView)
    func setupPrefetchDataSource(for collectionView: UICollectionView)
    func updateCollectionViewLayout(layout: UICollectionViewLayout)
    func fetchAlbumData()
    func removeAuthRecords()
    func removeAlbumRecords()
    func showPhotoViewController()
}

class GalleryModel: GalleryModelProtocol {

    let presenter: GalleryPresenterProtocol
    var dataSource: GalleryCollectionDataSourceProtocol
    var delegate: GalleryCollectionDelegateProtocol!
    var prefetchDataSource: GalleryCollectionDataSourcePrefetchProtocol


    init(presenter: GalleryPresenterProtocol,
         dataSource: GalleryCollectionDataSourceProtocol,
         prefetchDataSource: GalleryCollectionDataSourcePrefetchProtocol) {
        self.presenter = presenter
        self.dataSource = dataSource
        self.prefetchDataSource = prefetchDataSource
    }

    func registerCell(for collectionView: UICollectionView) {
        let nib = UINib(nibName: NibNames.galleryCollectionViewCell, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier)
    }

    func setupCollectionViewDelegate(for collectionView: UICollectionView) {
        collectionView.delegate = delegate
    }

    func setupCollectionViewDataSource(for collectionView: UICollectionView) {
        collectionView.dataSource = dataSource
    }

    func setupPrefetchDataSource(for collectionView: UICollectionView) {
        collectionView.prefetchDataSource = prefetchDataSource
    }

    func updateCollectionViewLayout(layout: UICollectionViewLayout) {
        guard let layout = layout as? UICollectionViewFlowLayout,
              let safeAreainsets = layout.collectionView?.superview?.safeAreaInsets,
              let safeAreaFrame = layout.collectionView?.superview?.safeAreaLayoutGuide.layoutFrame else {
            return
        }
        let side: CGFloat
        if safeAreaFrame.width < safeAreaFrame.height {
            side = GalleryFlowLayoutConstants.getSize(orientation: .vertical, currentWidth: safeAreaFrame.width)
        } else {
            side = GalleryFlowLayoutConstants.getSize(orientation: .horizontal, currentWidth: safeAreaFrame.width)
        }
        layout.itemSize = CGSize(width: side, height: side)
        layout.sectionInset = safeAreainsets
        layout.sectionInset.top = GalleryFlowLayoutConstants.topInset
        layout.minimumLineSpacing = GalleryFlowLayoutConstants.minimumLineSpacing
        layout.minimumInteritemSpacing = GalleryFlowLayoutConstants.minimumLineSpacing
    }

    func fetchAlbumData() {
        NetworkService.shared.getAlbumData { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let album):
                self.dataSource.album = album
                self.delegate.album = album
                self.prefetchDataSource.album = album
                UserDefaultsStorage.updateAlbumData(album: album)
                self.presenter.reloadCollectionView()
            case .failure(let error):
                self.handleGetAlbumError(error: error)
            }
        }
    }

    func showPhotoViewController() {
        let photoViewController = PhotoViewController(nibName: NibNames.photoViewController, bundle: nil)
        presenter.showPhotoViewController(photoViewController)
    }

    func removeAuthRecords() {
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
        UserDefaultsStorage.deleteCurrentToken()
        UserDefaultsStorage.updateIsTokenActual(with: false)
    }

    func removeAlbumRecords() {
        UserDefaultsStorage.deleteAlbum()
    }

    private func handleGetAlbumError(error: GetAlbumError) {
        switch error {
        case .unknownError:
            presenter.showAlertUnknownError()
        case .error(let error):
            presenter.showAlertError(error: error)
        case .userNotSignedIn:
            presenter.showAlertUserNotSignedIn()
        case .designatedError(let error):
            presenter.showAlertDesignatedError(error: error)
        }
    }
}
