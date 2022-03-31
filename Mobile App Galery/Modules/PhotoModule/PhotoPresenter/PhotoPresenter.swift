//
//  PhotoPresenter.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 29.03.2022.
//

import UIKit

protocol PhotoPresenterProtocol {
    func registerCell(for collectionView: UICollectionView)
    func setupCollectionViewDelegate(_ collectionView: UICollectionView)
    func setupCollectionViewDataSource(_ collectionView: UICollectionView)
    func updateCollectionViewLayout(layout: UICollectionViewLayout)
    func getAlbum()
    func reloadData()
    func updateTitle()
    func showCurrentTitle(title: String)
    func setupImage(for imageView: UIImageView)
    func updateCurrentPhoto(with image: UIImage)
    func getShareViewController()
    func presentShareViewController(viewController: UIViewController)
    func showAlertSuccessSave()
    func showAlertFailedSave()
    func handlePinchGesture(_ gesture: UIPinchGestureRecognizer)
    func hideViewsExceptPhoto()
    func showViews()
    func removePhotoRecords()
}

class PhotoPresenter: PhotoPresenterProtocol {
    
    var model: PhotoModelProtocol!
    let view: PhotoViewControllerProtocol

    init(view: PhotoViewControllerProtocol) {
        self.view = view
    }

    func registerCell(for collectionView: UICollectionView) {
        model.registerCell(for: collectionView)
    }

    func setupCollectionViewDelegate(_ collectionView: UICollectionView) {
        model.setupCollectionViewDelegate(collectionView)
    }

    func setupCollectionViewDataSource(_ collectionView: UICollectionView) {
        model.setupCollectionViewDataSource(collectionView)
    }

    func updateCollectionViewLayout(layout: UICollectionViewLayout) {
        model.updateCollectionViewLayout(layout: layout)
    }

    func getAlbum() {
        model.getAlbum()
    }

    func reloadData() {
        view.reloadData()
    }

    func updateTitle() {
        model.updateTitle()
    }

    func showCurrentTitle(title: String) {
        view.showCurrentTitle(title: title)
    }

    func setupImage(for imageView: UIImageView) {
        model.setupImage(for: imageView)
    }

    func updateCurrentPhoto(with image: UIImage) {
        view.updateCurrentPhoto(with: image)
    }

    func getShareViewController() {
        model.getShareViewController()
    }

    func presentShareViewController(viewController: UIViewController) {
        view.presentShareViewController(viewController: viewController)
    }

    func showAlertSuccessSave() {
        view.showAlertSuccessSave()
    }

    func showAlertFailedSave() {
        view.showAlertFailedSave()
    }

    func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        model.handlePinchGesture(gesture)
    }

    func hideViewsExceptPhoto() {
        view.hideViewsExceptPhoto()
    }

    func showViews() {
        view.showViews()
    }

    func removePhotoRecords() {
        model.removePhotoRecords()
    }
}
