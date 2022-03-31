//
//  GalleryCollectionViewDataSourcePrefetch.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 31.03.2022.
//

import UIKit
import SDWebImage

protocol GalleryCollectionDataSourcePrefetchProtocol: UICollectionViewDataSourcePrefetching {
    var album: Album? {get set}
}

class GalleryCollectionDataSourcePrefetch: NSObject, GalleryCollectionDataSourcePrefetchProtocol {

    var album: Album?

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier, for: indexPath) as? GalleryCollectionViewCell else {
                return
            }
            guard let album = album,
                  let imageUrl = album.response.items[indexPath.row][.w]?.url,
                  let url = URL(string: imageUrl) else {
                return
            }
            cell.imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imageView.sd_imageIndicator = SDWebImageProgressIndicator.default
            cell.imageView.sd_setImage(with: url)
        }
    }
}
