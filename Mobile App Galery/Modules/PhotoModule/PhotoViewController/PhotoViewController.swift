//
//  PhotoViewController.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 28.03.2022.
//

import UIKit
import SDWebImage

protocol PhotoViewControllerProtocol: UIViewController {
    var presenter: PhotoPresenterProtocol! {get set}
    var carouselCollectionView: UICollectionView! {get set}
    func reloadData()
    func updateCurrentTitle()
    func updateCurrentImage()
}

class PhotoViewController: UIViewController, PhotoViewControllerProtocol {

    var presenter: PhotoPresenterProtocol!
    let configurator: PhotoConfiguratorProtocol
    let alertFactory: AlertFactoryProtocol
    let shareViewControllerFactory: ShareViewControllerFactoryProtocol
    let pinchGestureRecognizer: UIPinchGestureRecognizer

    @IBOutlet weak var currentPhotoImageView: UIImageView!
    @IBOutlet weak var carouselCollectionView: UICollectionView!

    init(configurator: PhotoConfiguratorProtocol,
         alertFactory: AlertFactoryProtocol,
         shareViewControllerFactory: ShareViewControllerFactoryProtocol,
         pinchGestureRecognizer: UIPinchGestureRecognizer) {
        self.configurator = configurator
        self.alertFactory = alertFactory
        self.pinchGestureRecognizer = pinchGestureRecognizer
        self.shareViewControllerFactory = shareViewControllerFactory
        super.init(nibName: NibNames.photoViewController, bundle: nil)
    }

    convenience init() {
        let configurator = PhotoConfigurator()
        let alertFactory = AlertFactory()
        let shareViewControllerFactory = ShareViewControllerFactory()
        let pinchGestureRecognizer = UIPinchGestureRecognizer()
        self.init(configurator: configurator,
                  alertFactory: alertFactory,
                  shareViewControllerFactory: shareViewControllerFactory,
                  pinchGestureRecognizer: pinchGestureRecognizer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(view: self)
        registerCell(for: carouselCollectionView)
        setupNavigationBarItems()
        setupGestureRecognizer()
        updateCurrentTitle()
        setupImage()
        presenter.getAlbum()
    }

    override func viewSafeAreaInsetsDidChange() {
        updateCollectionViewLayout()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.removePhotoRecords()
        presenter.removeDateRecords()
    }

    @objc func shareButtonTapped() {
        presentShareViewController()
    }

    @objc func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        guard let gestureView = gesture.view else { return }
        let location = gesture.location(in: gestureView)
        switch gesture.state {
        case .began:
            hideViewsExceptPhoto()
        case .changed:
            let pinchCenter = CGPoint(x: location.x - gestureView.bounds.midX, y: location.y - gestureView.bounds.midY)
            let transform = gestureView.transform.translatedBy(x: pinchCenter.x, y: pinchCenter.y)
                .scaledBy(x: gesture.scale, y: gesture.scale)
                .translatedBy(x: -pinchCenter.x, y: -pinchCenter.y)
            gestureView.transform = transform
            gesture.scale = PhotoViewControllerConstants.gestureScale
        case .ended:
            UIView.animate(withDuration: PhotoViewControllerConstants.animateDuration) { [weak gestureView] in
                guard let gestureView = gestureView else { return }
                gestureView.transform = CGAffineTransform.identity
            }
            showViews()
        default:
            break
        }
    }

    func reloadData() {
        carouselCollectionView.reloadData()
    }

    func updateCurrentTitle() {
        guard let date = UserDefaultsStorage.getCurrentDate() else {
            return
        }
        title = date
    }

    func updateCurrentImage() {
        guard let data = UserDefaultsStorage.getCurrentPhotoData(),
              let image = UIImage(data: data) else {
            return
        }
        currentPhotoImageView.image = image
    }

    private func registerCell(for collectionView: UICollectionView) {
        let nib = UINib(nibName: NibNames.photoCollectionViewCell, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
    }

    private func presentShareViewController() {
        guard let vc = shareViewControllerFactory.produce() else { return }
        vc.completionWithItemsHandler = { [weak self] _, isShared, _, error in
            guard let self = self else { return }
            isShared ? (error == nil) ? self.showAlertSuccessSave() : self.showAlertFailedSave() : nil
        }
        present(vc, animated: true)
    }

    private func updateCollectionViewLayout() {
        guard let layout = carouselCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let sideSize = PhotoFlowLayoutConstants.sideSize
        layout.itemSize = CGSize(width: sideSize, height: sideSize)
        layout.minimumLineSpacing = PhotoFlowLayoutConstants.minimumLineSpacing
    }

    private func setupImage() {
        guard let item = UserDefaultsStorage.getCurrentItem(),
              let currentUrlString = item[.w]?.url,
              let url = URL(string: currentUrlString) else {
            return
        }
        currentPhotoImageView.sd_setImage(with: url, completed: nil)
    }

    private func setupNavigationBarItems() {
        let button = UIBarButtonItem(config: .shareButtonItem)
        button.action = #selector(shareButtonTapped)
        button.target = self
        navigationItem.rightBarButtonItem = button
    }

    private func setupGestureRecognizer() {
        pinchGestureRecognizer.addTarget(self, action: #selector(handlePinchGesture(_:)))
        currentPhotoImageView.addGestureRecognizer(pinchGestureRecognizer)
    }

    func showAlertSuccessSave() {
        let alert = alertFactory.produce(with: .saveImageSuccess)
        alert.addAction(config: .ok)
        present(alert, animated: true)
    }

    func showAlertFailedSave() {
        let alert = alertFactory.produce(with: .saveImageFailed)
        alert.addAction(config: .ok)
        present(alert, animated: true)
    }

    private func showViews() {
        UIView.animate(withDuration: PhotoViewControllerConstants.animateDuration) { [weak self] in
            guard let self = self else { return }
            self.carouselCollectionView.layer.opacity = PhotoViewControllerConstants.maxOpacity
            self.navigationController?.navigationBar.layer.opacity = PhotoViewControllerConstants.maxOpacity
        }
    }

    private func hideViewsExceptPhoto() {
        UIView.animate(withDuration: PhotoViewControllerConstants.animateDuration) { [weak self] in
            guard let self = self else { return }
            self.carouselCollectionView.layer.opacity = PhotoViewControllerConstants.minOpacity
            self.navigationController?.navigationBar.layer.opacity = PhotoViewControllerConstants.minOpacity
        }
    }
}
