//
//  PhotoModel.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 29.03.2022.
//

import UIKit
import SDWebImage

protocol PhotoModelProtocol {
    func setupCollectionViewDelegate(_ collectionView: UICollectionView)
    func setupCollectionViewDataSource(_ collectionView: UICollectionView)
    func registerCell(for collectionView: UICollectionView)
    func updateCollectionViewLayout(layout: UICollectionViewFlowLayout)
    func setupImage(for imageView: UIImageView)
    func getTitle()
    func getAlbum()
    func prepareShareViewController()
    func handlePinchGesture(_ gesture: UIPinchGestureRecognizer)
}

class PhotoModel: NSObject, PhotoModelProtocol {

    let presenter: PhotoPresenterProtocol
    var album: Album?

    init(presenter: PhotoPresenterProtocol) {
        self.presenter = presenter
    }

    func setupCollectionViewDelegate(_ collectionView: UICollectionView) {
        collectionView.delegate = self
    }

    func setupCollectionViewDataSource(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
    }

    func registerCell(for collectionView: UICollectionView) {
        let nib = UINib(nibName: NibNames.photoCollectionViewCell, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
    }

    func updateCollectionViewLayout(layout: UICollectionViewFlowLayout) {
        layout.itemSize = CGSize(width: PhotoFlowLayoutConstants.sideSize, height: PhotoFlowLayoutConstants.sideSize)
        layout.minimumLineSpacing = PhotoFlowLayoutConstants.minimumLineSpacing
    }

    func setupImage(for imageView: UIImageView) {
        guard let item = UserDefaultsStorage.getCurrentItem(),
              let currentUrlString = item[.w]?.url,
              let url = URL(string: currentUrlString) else {
            return
        }
        imageView.sd_setImage(with: url, completed: nil)
    }

    func getTitle() {
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
        presenter.setTitle(resultString)
    }

    func getAlbum() {
        let album = UserDefaultsStorage.getAlbum()
        self.album = album
        presenter.reloadData()
    }

    func prepareShareViewController() {
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
        presenter.sendShareViewController(viewController: vc)
    }

    func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        guard let gestureView = gesture.view else {
            return
        }
        let location = gesture.location(in: gestureView)
        switch gesture.state {
        case .changed:
            let pinchCenter = CGPoint(x: location.x - gestureView.bounds.midX,
                                      y: location.y - gestureView.bounds.midY)
            let transform = gestureView.transform.translatedBy(x: pinchCenter.x, y: pinchCenter.y)
                                            .scaledBy(x: gesture.scale, y: gesture.scale)
                                            .translatedBy(x: -pinchCenter.x, y: -pinchCenter.y)
            gestureView.transform = transform
            presenter.hideViewsExceptPhoto()
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
}

extension PhotoModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let album = album else {
            return 0
        }
        return album.response.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let urlString = album?.response.items[indexPath.row][.w]?.url,
              let url = URL(string: urlString) else {
            return UICollectionViewCell()
        }
        cell.cellImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.cellImageView.sd_imageIndicator = SDWebImageProgressIndicator.default
        cell.cellImageView.sd_setImage(with: url, completed: nil)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell,
              let data = cell.cellImageView.image?.sd_imageData() else {
            return
        }
        UserDefaultsStorage.saveCurrentPhotoData(data: data)
        presenter.updateCurrentPhoto()
    }
}
