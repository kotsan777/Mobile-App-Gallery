//
//  PhotoCollectionDataSource.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 31.03.2022.
//

import UIKit
import SDWebImage

protocol PhotoCollectionDataSourceProtocol: UICollectionViewDataSource {
    var album: Album? {get set}
}

class PhotoCollectionDataSource: NSObject, PhotoCollectionDataSourceProtocol {

    var album: Album?

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
}
