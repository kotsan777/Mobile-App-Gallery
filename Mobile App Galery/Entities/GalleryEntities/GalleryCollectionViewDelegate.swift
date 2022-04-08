//
//  GalleryCollectionViewDelegate.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 31.03.2022.
//

import UIKit

protocol GalleryCollectionDelegateProtocol: UICollectionViewDelegate {
    var album: Album? {get set}
    var model: GalleryModelProtocol? {get set}
}

class GalleryCollectionDelegate: NSObject, GalleryCollectionDelegateProtocol {
    var album: Album?
    var model: GalleryModelProtocol?

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = model,
              let currentItem = album?.response.items[indexPath.row],
              let cell = collectionView.cellForItem(at: indexPath) as? GalleryCollectionViewCell,
              let currentImageData = cell.imageView.image?.sd_imageData() else {
            return
        }
        UserDefaultsStorage.updateCurrentPhotoData(data: currentImageData)
        UserDefaultsStorage.updateCurrentItem(item: currentItem)
        model.showPhotoViewController()
    }
}
