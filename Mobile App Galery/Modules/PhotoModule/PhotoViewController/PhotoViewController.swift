//
//  PhotoViewController.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 28.03.2022.
//

import UIKit

protocol PhotoViewControllerProtocol: UIViewController {
    var presenter: PhotoPresenterProtocol! {get set}
    func setTitle(_ title: String)
    func reloadData()
    func presentShareViewController(viewController: UIActivityViewController)
    func showAlertSuccessSave()
    func showAlertFailedSave()
    func updateCurrentPhoto()
}

class PhotoViewController: UIViewController, PhotoViewControllerProtocol {

    var presenter: PhotoPresenterProtocol!
    let configurator = PhotoConfigurator()

    @IBOutlet weak var currentPhotoImageView: UIImageView!
    @IBOutlet weak var carouselCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(view: self)
        setupViewController()
        setupCollectionViewDelegate(carouselCollectionView)
        setupCollectionViewDataSource(carouselCollectionView)
        registerCell(for: carouselCollectionView)
        setupImage(for: currentPhotoImageView)
        getTitle()
        presenter.getAlbum()
    }

    override func viewSafeAreaInsetsDidChange() {
        guard let collectionViewLayout = carouselCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        presenter.updateCollectionViewLayout(layout: collectionViewLayout)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaultsStorage.deleteCurrentItem()
    }

    @objc func shareButtonTapped() {
        presenter.prepareShareViewController()
    }

    func setTitle(_ title: String) {
        self.title = title
    }

    func reloadData() {
        carouselCollectionView.reloadData()
    }

    func presentShareViewController(viewController: UIActivityViewController) {
        present(viewController, animated: true)
    }

    func updateCurrentPhoto() {
        guard let data = UserDefaultsStorage.getCurrentPhotoData() else {
            return
        }
        let image = UIImage(data: data)
        currentPhotoImageView.image = image
    }

    private func setupCollectionViewDelegate(_ collectionView: UICollectionView) {
        presenter.setupCollectionViewDelegate(collectionView)
    }

    private func setupCollectionViewDataSource(_ collectionView: UICollectionView) {
        presenter.setupCollectionViewDataSource(collectionView)
    }

    private func registerCell(for collectionView: UICollectionView) {
        presenter.registerCell(for: collectionView)
    }

    private func setupImage(for imageView: UIImageView) {
        guard let data = UserDefaultsStorage.getCurrentPhotoData() else {
            return
        }
        let image = UIImage(data: data)
        imageView.image = image
        presenter.setupImage(for: imageView)
    }

    private func getTitle() {
        presenter.getTitle()
    }

    func setupViewController() {
        let button = UIBarButtonItem(config: .shareButtonItem)
        button.action = #selector(shareButtonTapped)
        button.target = self
        navigationItem.rightBarButtonItem = button
    }

    func showAlertSuccessSave() {
        let alert = UIAlertController(config: .saveImageSuccess)
        present(alert, animated: true)
    }

    func showAlertFailedSave() {
        let alert = UIAlertController(config: .saveImageFailed)
        present(alert, animated: true)
    }
}
