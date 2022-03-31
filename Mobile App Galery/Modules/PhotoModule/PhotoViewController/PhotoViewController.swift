//
//  PhotoViewController.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 28.03.2022.
//

import UIKit

protocol PhotoViewControllerProtocol: UIViewController {
    var presenter: PhotoPresenterProtocol! {get set}
    func reloadData()
    func updateCurrentPhoto(with image: UIImage)
    func showCurrentTitle(title: String)
    func showViews()
    func hideViewsExceptPhoto()
    func presentShareViewController(viewController: UIViewController)
    func showAlertSuccessSave()
    func showAlertFailedSave()
}

class PhotoViewController: UIViewController, PhotoViewControllerProtocol {

    var presenter: PhotoPresenterProtocol!
    let configurator = PhotoConfigurator()
    var pinchGestureRecognizer: UIPinchGestureRecognizer!

    @IBOutlet weak var currentPhotoImageView: UIImageView!
    @IBOutlet weak var carouselCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(view: self)
        registerCell(for: carouselCollectionView)
        setupNavigationBarItems()
        setupCollectionViewDelegate(carouselCollectionView)
        setupCollectionViewDataSource(carouselCollectionView)
        setupImage(for: currentPhotoImageView)
        setupGestureRecognizer()
        presenter.getAlbum()
        updateTitle()
    }

    override func viewSafeAreaInsetsDidChange() {
        presenter.updateCollectionViewLayout(layout: carouselCollectionView.collectionViewLayout)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.removePhotoRecords()
    }

    @objc func shareButtonTapped() {
        presenter.getShareViewController()
    }

    @objc func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        presenter.handlePinchGesture(gesture)
    }

    func reloadData() {
        carouselCollectionView.reloadData()
    }

    func updateCurrentPhoto(with image: UIImage) {
        currentPhotoImageView.image = image
    }

    func showCurrentTitle(title: String) {
        self.title = title
    }

    func showViews() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.carouselCollectionView.layer.opacity = 1
            self.navigationController?.navigationBar.layer.opacity = 1
        }
    }

    func hideViewsExceptPhoto() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.carouselCollectionView.layer.opacity = 0
            self.navigationController?.navigationBar.layer.opacity = 0
        }
    }

    func presentShareViewController(viewController: UIViewController) {
        present(viewController, animated: true)
    }

    func showAlertSuccessSave() {
        let alert = UIAlertController(config: .saveImageSuccess)
        alert.addAction(config: .ok)
        present(alert, animated: true)
    }

    func showAlertFailedSave() {
        let alert = UIAlertController(config: .saveImageFailed)
        alert.addAction(config: .ok)
        present(alert, animated: true)
    }

    private func registerCell(for collectionView: UICollectionView) {
        presenter.registerCell(for: collectionView)
    }

    private func setupCollectionViewDelegate(_ collectionView: UICollectionView) {
        presenter.setupCollectionViewDelegate(collectionView)
    }

    private func setupCollectionViewDataSource(_ collectionView: UICollectionView) {
        presenter.setupCollectionViewDataSource(collectionView)
    }

    private func updateTitle() {
        presenter.updateTitle()
    }

    private func setupImage(for imageView: UIImageView) {
        presenter.setupImage(for: imageView)
    }

    private func setupNavigationBarItems() {
        let button = UIBarButtonItem(config: .shareButtonItem)
        button.action = #selector(shareButtonTapped)
        button.target = self
        navigationItem.rightBarButtonItem = button
    }

    private func setupGestureRecognizer() {
        pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        currentPhotoImageView.addGestureRecognizer(pinchGestureRecognizer)
    }
}
