//
//  GalleryCollectionViewController.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit
import WebKit

protocol GalleryViewAlertable {
    func showAlertError(error: Error)
    func showAlertUnknownError()
    func showAlertUserNotSignedIn()
    func showAlertDesignatedError(error: DesignatedError)
}

protocol GalleryCollectionViewControllerProtocol: UICollectionViewController, GalleryViewAlertable {
    func reloadCollectionView()
    func showPhotoViewController()
}

class GalleryCollectionViewController: UICollectionViewController, GalleryCollectionViewControllerProtocol {

    let configurator: GalleryConfiguratorProtocol
    let alertFactory: AlertFactoryProtocol
    var presenter: GalleryPresenterProtocol!

    init(configurator: GalleryConfiguratorProtocol, alertFactory: AlertFactoryProtocol) {
        self.configurator = configurator
        self.alertFactory = alertFactory
        super.init(nibName: NibNames.galleryCollectionViewController, bundle: nil)
        navigationItem.setHidesBackButton(true, animated: false)
        title = NavigationControllerConstants.galleryViewControllerTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(config: .exitFromGallery)
        navigationItem.backBarButtonItem = UIBarButtonItem(config: .defaultBackButtonItem)
        navigationItem.rightBarButtonItem?.action = #selector(exit)
        navigationItem.rightBarButtonItem?.target = self
    }

    convenience init() {
        let configurator = GalleryConfigurator()
        let alertFactory = AlertFactory()
        self.init(configurator: configurator, alertFactory: alertFactory)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(view: self)
        registerCell(for: collectionView)
        presenter.fetchAlbumData()
    }

    override func viewSafeAreaInsetsDidChange() {
        updateCollectionViewLayout(layout: collectionViewLayout)
    }

    @objc func exit() {
        navigationController?.popViewController(animated: true)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
        presenter.removeAuthRecords()
        presenter.removeAlbumRecords()
    }

    func reloadCollectionView() {
        collectionView.reloadData()
    }

    func showPhotoViewController() {
        let photoViewController = PhotoViewController()
        navigationController?.pushViewController(photoViewController, animated: true)
    }

    func showAlertError(error: Error) {
        let alert = alertFactory.produce(with: .error(error))
        alert.addAction(config: .ok)
        alert.addAction(config: .reload) { [weak self] _ in
            guard let self = self else { return }
            self.presenter.fetchAlbumData()
        }
        present(alert, animated: true)
    }

    func showAlertUnknownError() {
        let alert = alertFactory.produce(with: .unknownError)
        alert.addAction(config: .ok)
        present(alert, animated: true)
    }

    func showAlertUserNotSignedIn() {
        let alert = alertFactory.produce(with: .userNotSignedIn)
        alert.addAction(config: .cancell)
        alert.addAction(config: .ok) { [weak self] _ in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        present(alert, animated: true)
    }

    func showAlertDesignatedError(error: DesignatedError) {
        let alert = alertFactory.produce(with: .designatedError(error))
        alert.addAction(config: .ok)
        present(alert, animated: true)
    }

    private func registerCell(for collectionView: UICollectionView) {
        let nib = UINib(nibName: NibNames.galleryCollectionViewCell, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier)
    }

    private func updateCollectionViewLayout(layout: UICollectionViewLayout) {
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
}
