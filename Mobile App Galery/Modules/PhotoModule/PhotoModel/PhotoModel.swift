//
//  PhotoModel.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 29.03.2022.
//

import SDWebImage

protocol PhotoModelProtocol {
    func registerCell(for collectionView: UICollectionView)
    func setupCollectionViewDelegate(_ collectionView: UICollectionView)
    func setupCollectionViewDataSource(_ collectionView: UICollectionView)
    func updateCollectionViewLayout(layout: UICollectionViewLayout)
    func getAlbum()
    func setupImage(for imageView: UIImageView)
    func updateTitle()
    func getShareViewController()
    func handlePinchGesture(_ gesture: UIPinchGestureRecognizer)
    func removePhotoRecords()
    func photoSelected()
}

class PhotoModel: NSObject, PhotoModelProtocol {

    let presenter: PhotoPresenterProtocol
    var album: Album?
    var delegate: PhotoCollectionDelegateProtocol!
    var dataSource: PhotoCollectionDataSourceProtocol

    init(presenter: PhotoPresenterProtocol, dataSource: PhotoCollectionDataSourceProtocol) {
        self.presenter = presenter
        self.dataSource = dataSource
    }

    func registerCell(for collectionView: UICollectionView) {
        let nib = UINib(nibName: NibNames.photoCollectionViewCell, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
    }

    func setupCollectionViewDelegate(_ collectionView: UICollectionView) {
        collectionView.delegate = delegate
    }

    func setupCollectionViewDataSource(_ collectionView: UICollectionView) {
        collectionView.dataSource = dataSource
    }

    func updateCollectionViewLayout(layout: UICollectionViewLayout) {
        guard let layout = layout as? UICollectionViewFlowLayout else {
            return
        }
        let sideSize = PhotoFlowLayoutConstants.sideSize
        layout.itemSize = CGSize(width: sideSize, height: sideSize)
        layout.minimumLineSpacing = PhotoFlowLayoutConstants.minimumLineSpacing
    }

    func getAlbum() {
        let album = UserDefaultsStorage.getAlbum()
        dataSource.album = album
        delegate.album = album
        presenter.reloadData()
    }

    func setupImage(for imageView: UIImageView) {
        guard let item = UserDefaultsStorage.getCurrentItem(),
              let currentUrlString = item[.w]?.url,
              let url = URL(string: currentUrlString) else {
            return
        }
        imageView.sd_setImage(with: url, completed: nil)
    }

    func updateTitle() {
        guard let item = UserDefaultsStorage.getCurrentItem() else {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let unixDate = item.date
        let date = Date(timeIntervalSince1970: Double(unixDate))
        let rawDateString = dateFormatter.string(from: date)
        let resultString = String(rawDateString.dropLast(3))
        presenter.showCurrentTitle(title: resultString)
    }

    func getShareViewController() {
        guard let currentPhotoImageData = UserDefaultsStorage.getCurrentPhotoData(),
              let image = UIImage(data: currentPhotoImageData) else {
            return
        }
        let activityItem: [Any] = [image as Any]
        let vc = UIActivityViewController(activityItems: activityItem, applicationActivities: nil)
        vc.completionWithItemsHandler = { [weak self] _, isShared, _, error in
            guard let self = self else {
                return
            }
            if isShared {
                (error == nil) ? self.presenter.showAlertSuccessSave() : self.presenter.showAlertFailedSave()
            }
        }
        presenter.presentShareViewController(viewController: vc)
    }

    func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        guard let gestureView = gesture.view else {
            return
        }
        let location = gesture.location(in: gestureView)
        switch gesture.state {
        case .began:
            presenter.hideViewsExceptPhoto()
        case .changed:
            let pinchCenter = CGPoint(x: location.x - gestureView.bounds.midX,
                                      y: location.y - gestureView.bounds.midY)
            let transform = gestureView.transform.translatedBy(x: pinchCenter.x, y: pinchCenter.y)
                                            .scaledBy(x: gesture.scale, y: gesture.scale)
                                            .translatedBy(x: -pinchCenter.x, y: -pinchCenter.y)
            gestureView.transform = transform
            gesture.scale = 1
        case .ended:
            UIView.animate(withDuration: 0.5) {
                gestureView.transform = CGAffineTransform.identity
            }
            presenter.showViews()
        default:
            break
        }
    }

    func photoSelected() {
        guard let data = UserDefaultsStorage.getCurrentPhotoData(),
              let image = UIImage(data: data) else {
            return
        }
        presenter.updateCurrentPhoto(with: image)
        updateTitle()
    }

    func removePhotoRecords() {
        UserDefaultsStorage.deleteCurrentPhotoData()
        UserDefaultsStorage.deleteCurrentItem()
    }
}
