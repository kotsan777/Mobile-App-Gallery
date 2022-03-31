//
//  GalleryPresenter.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 27.03.2022.
//

import UIKit

protocol GalleryPresenterProtocol: AnyObject {
    func registerCell(for collectionView: UICollectionView)
    func setupCollectionViewDelegate(for collectionView: UICollectionView)
    func setupCollectionViewDataSource(for collectionView: UICollectionView)
    func setupPrefetchDataSource(for collectionView: UICollectionView)
    func updateCollectionViewLayout(layout: UICollectionViewLayout)
    func fetchAlbumData()
    func reloadCollectionView()
    func showPhotoViewController(_ photoViewController: PhotoViewControllerProtocol)
    func showAlertError(error: Error)
    func showAlertUserNotSignedIn()
    func showAlertDesignatedError(error: DesignatedError)
    func showAlertUnknownError()
    func removeAuthRecords()
    func removeAlbumRecords()
}

class GalleryPresenter: GalleryPresenterProtocol {

    let view: GalleryCollectionViewControllerProtocol
    var model: GalleryModelProtocol!

    init(view: GalleryCollectionViewControllerProtocol) {
        self.view = view
    }

    func registerCell(for collectionView: UICollectionView) {
        model.registerCell(for: collectionView)
    }

    func setupCollectionViewDelegate(for collectionView: UICollectionView) {
        model.setupCollectionViewDelegate(for: collectionView)
    }

    func setupCollectionViewDataSource(for collectionView: UICollectionView) {
        model.setupCollectionViewDataSource(for: collectionView)
    }

    func setupPrefetchDataSource(for collectionView: UICollectionView) {
        model.setupPrefetchDataSource(for: collectionView)
    }

    func updateCollectionViewLayout(layout: UICollectionViewLayout) {
        model.updateCollectionViewLayout(layout: layout)
    }

    func fetchAlbumData() {
        model.fetchAlbumData()
    }

    func reloadCollectionView() {
        view.reloadCollectionView()
    }

    func showAlertError(error: Error) {
        view.showAlertError(error: error)
    }

    func showAlertUnknownError() {
        view.showAlertUnknownError()
    }

    func showAlertUserNotSignedIn() {
        view.showAlertUserNotSignedIn()
    }

    func showAlertDesignatedError(error: DesignatedError) {
        view.showAlertDesignatedError(error: error)
    }

    func showPhotoViewController(_ photoViewController: PhotoViewControllerProtocol) {
        view.showPhotoViewController(photoViewController)
    }

    func removeAuthRecords() {
        model.removeAuthRecords()
    }

    func removeAlbumRecords() {
        model.removeAlbumRecords()
    }
}
