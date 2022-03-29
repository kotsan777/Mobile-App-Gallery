//
//  GalleryPresenter.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 27.03.2022.
//

import UIKit

protocol GalleryPresenterProtocol {
    func registerCell(for collectionView: UICollectionView)
    func setupCollectionViewDelegate(for collectionView: UICollectionView)
    func setupCollectionViewDataSource(for collectionView: UICollectionView)
    func setupPrefetchDataSource(for collectionView: UICollectionView)
    func updateCollectionViewLayout(layout: UICollectionViewFlowLayout, with safeAreaLayoutGuide: UILayoutGuide)
    func fetchAlbumData()
    func reloadCollectionView()
    func showAlertError(error: Error)
    func showAlertDataIsEmpty()
    func showAlertAccessFailed()
    func showAlertUnknownError()
    func showAlertParsImageError()
    func showPhotoViewController(_ photoViewController: PhotoViewControllerProtocol)
    func removeAuthRecords()
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

    func updateCollectionViewLayout(layout: UICollectionViewFlowLayout, with safeAreaLayoutGuide: UILayoutGuide) {
        model.updateCollectionViewLayout(layout: layout, with: safeAreaLayoutGuide)
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

    func showAlertDataIsEmpty() {
        view.showAlertDataIsEmpty()
    }

    func showAlertAccessFailed() {
        view.showAlertAccessFailed()
    }

    func showAlertUnknownError() {
        view.showAlertUnknownError()
    }

    func showAlertParsImageError() {
        view.showAlertParsImageError()
    }

    func showPhotoViewController(_ photoViewController: PhotoViewControllerProtocol) {
        view.showPhotoViewController(photoViewController)
    }

    func removeAuthRecords() {
        model.removeAuthRecords()
    }
}
