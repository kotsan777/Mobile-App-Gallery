//
//  GalleryCollectionViewDataSource.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 31.03.2022.
//

import UIKit
import SDWebImage

protocol GalleryCollectionDataSourceProtocol: UICollectionViewDataSource {
    var album: Album? {get set}
}

class GalleryCollectionDataSource: NSObject, GalleryCollectionDataSourceProtocol {
    var album: Album?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let album = album else {
            return 0
        }
        return album.response.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier, for: indexPath) as? GalleryCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let album = album,
              let imageUrl = album.response.items[indexPath.row][.w]?.url,
              let url = URL(string: imageUrl) else {
            return UICollectionViewCell()
        }
        cell.imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        cell.imageView.sd_imageIndicator = SDWebImageProgressIndicator.bar
        cell.imageView.sd_setImage(with: url, placeholderImage: UIImage())
        return cell
    }
}
