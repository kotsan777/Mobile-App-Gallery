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
        guard let urlString = album?.response.items[indexPath.row][.x]?.url,
              let url = URL(string: urlString) else {
            return UICollectionViewCell()
        }
        cell.cellImageView.sd_setImage(with: url, completed: nil)
        return cell
    }
}
