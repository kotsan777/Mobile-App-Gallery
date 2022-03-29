//
//  PhotoModel.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 29.03.2022.
//

import UIKit

protocol PhotoModelProtocol {
    func setupCollectionViewDelegate(_ collectionView: UICollectionView)
    func setupCollectionViewDataSource(_ collectionView: UICollectionView)
    func registerCell(for collectionView: UICollectionView)
    func updateCollectionViewLayout(layout: UICollectionViewFlowLayout)
    func setupImage(for imageView: UIImageView)
    func getTitle()
    func getAlbum()
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
        let data = UserDefaultsStorage.getCurrentPhotoData()
        let image = UIImage(data: data)
        imageView.image = image
    }

    func getTitle() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let unixDate = UserDefaultsStorage.getCurrentPhotoDate()
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
        guard let urlString = album?.response.items[indexPath.row][.x]?.url else {
            return UICollectionViewCell()
        }
        NetworkService.shared.getImage(with: urlString) { result in
            switch result {
            case .success(let image):
                cell.cellImageView.image = image
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return cell
    }
}
