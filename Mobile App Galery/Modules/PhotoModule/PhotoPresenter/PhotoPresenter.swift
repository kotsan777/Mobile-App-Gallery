//
//  PhotoPresenter.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 29.03.2022.
//

import UIKit

protocol PhotoPresenterProtocol {
    func setupCollectionViewDelegate(_ collectionView: UICollectionView)
    func setupCollectionViewDataSource(_ collectionView: UICollectionView)
    func registerCell(for collectionView: UICollectionView)
    func updateCollectionViewLayout(layout: UICollectionViewFlowLayout)
    func setupImage(for imageView: UIImageView)
    func getTitle()
    func setTitle(_ title: String)
    func getAlbum()
    func reloadData()
    func prepareShareViewController()
    func sendShareViewController(viewController: UIActivityViewController)
    func showAlertSuccessSave()
    func showAlertFailedSave()
    func updateCurrentPhoto()
}

class PhotoPresenter: PhotoPresenterProtocol {
    
    var model: PhotoModelProtocol!
    let view: PhotoViewControllerProtocol

    init(view: PhotoViewControllerProtocol) {
        self.view = view
    }

    func setupCollectionViewDelegate(_ collectionView: UICollectionView) {
        model.setupCollectionViewDelegate(collectionView)
    }

    func setupCollectionViewDataSource(_ collectionView: UICollectionView) {
        model.setupCollectionViewDataSource(collectionView)
    }

    func registerCell(for collectionView: UICollectionView) {
        model.registerCell(for: collectionView)
    }

    func updateCollectionViewLayout(layout: UICollectionViewFlowLayout) {
        model.updateCollectionViewLayout(layout: layout)
    }

    func setupImage(for imageView: UIImageView) {
        model.setupImage(for: imageView)
    }

    func getTitle() {
        model.getTitle()
    }

    func setTitle(_ title: String) {
        view.setTitle(title)
    }

    func getAlbum() {
        model.getAlbum()
    }

    func reloadData() {
        view.reloadData()
    }

    func prepareShareViewController() {
        model.prepareShareViewController()
    }

    func sendShareViewController(viewController: UIActivityViewController) {
        view.presentShareViewController(viewController: viewController)
    }

    func showAlertSuccessSave() {
        view.showAlertSuccessSave()
    }

    func showAlertFailedSave() {
        view.showAlertFailedSave()
    }

    func updateCurrentPhoto() {
        view.updateCurrentPhoto()
    }
}
