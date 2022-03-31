//
//  GalleryCollectionViewController.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit

protocol GalleryCollectionViewControllerProtocol: UIViewController {
    func reloadCollectionView()
    func showAlertError(error: Error)
    func showAlertUnknownError()
    func showPhotoViewController(_ photoViewController: PhotoViewControllerProtocol)
    func showAlertUserNotSignedIn()
    func showAlertDesignatedError(error: DesignatedError)
}

class GalleryCollectionViewController: UICollectionViewController, GalleryCollectionViewControllerProtocol {

    let configurator = GalleryConfigurator()
    var presenter: GalleryPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(view: self)
        setupViewController()
        registerCell(for: collectionView)
        setupCollectionViewDelegate(for: collectionView)
        setupCollectionViewDataSource(for: collectionView)
        setupPrefetchDataSource(for: collectionView)
        fetchAlbumData()
    }

    override func viewSafeAreaInsetsDidChange() {
        guard let collectionViewLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        presenter.updateCollectionViewLayout(layout: collectionViewLayout, with: view.safeAreaLayoutGuide)
    }

    @objc func exit() {
        navigationController?.popViewController(animated: true)
        presenter.removeAuthRecords()
        presenter.removeAlbumRecords()
    }

    func reloadCollectionView() {
        collectionView.reloadData()
    }

    func showAlertError(error: Error) {
        let alert = UIAlertController(config: .error(error))
        alert.addAction(config: .ok)
        alert.addAction(config: .reload) { [weak presenter] _ in
            presenter?.fetchAlbumData()
        }
        present(alert, animated: true)
    }

    func showAlertUnknownError() {
        let alert = UIAlertController(config: .unknownError)
        alert.addAction(config: .ok)
        present(alert, animated: true)
    }

    func showAlertUserNotSignedIn() {
        let alert = UIAlertController(config: .userNotSignedIn)
        alert.addAction(config: .cancell)
        alert.addAction(config: .ok) { [weak navigationController] _ in
            navigationController?.popViewController(animated: true)
        }
        present(alert, animated: true)
    }

    func showAlertDesignatedError(error: DesignatedError) {
        let alert = UIAlertController(config: .designatedError(error))
        alert.addAction(config: .ok)
        present(alert, animated: true)
    }

    func showPhotoViewController(_ photoViewController: PhotoViewControllerProtocol) {
        navigationController?.pushViewController(photoViewController, animated: true)
    }

    private func registerCell(for collectionView: UICollectionView) {
        presenter.registerCell(for: collectionView)
    }

    private func setupCollectionViewDelegate(for collectionView: UICollectionView) {
        presenter.setupCollectionViewDelegate(for: collectionView)
    }

    private func setupCollectionViewDataSource(for collectionView: UICollectionView) {
        presenter.setupCollectionViewDataSource(for: collectionView)
    }

    private func setupPrefetchDataSource(for collectionView: UICollectionView) {
        presenter.setupPrefetchDataSource(for: collectionView)
    }

    private func fetchAlbumData() {
        presenter.fetchAlbumData()
    }

    private func setupViewController() {
        navigationItem.setHidesBackButton(true, animated: false)
        title = NavigationControllerConstants.galleryViewControllerTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(config: .exitFromGallery)
        navigationItem.backBarButtonItem = UIBarButtonItem(config: .defaultBackButtonItem)
        navigationItem.rightBarButtonItem?.action = #selector(exit)
        navigationItem.rightBarButtonItem?.target = self
    }
}
