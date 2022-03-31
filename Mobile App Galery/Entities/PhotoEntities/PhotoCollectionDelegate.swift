//
//  PhotoCollectionDelegate.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 31.03.2022.
//

import UIKit

protocol PhotoCollectionDelegateProtocol: UICollectionViewDelegate {
    var album: Album? {get set}
}

class PhotoCollectionDelegate: NSObject, PhotoCollectionDelegateProtocol {

    var album: Album?
    var model: PhotoModelProtocol

    init(model: PhotoModelProtocol) {
        self.model = model
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell,
              let data = cell.cellImageView.image?.sd_imageData(),
              let item = album?.response.items[indexPath.row] else {
            return
        }
        UserDefaultsStorage.updateCurrentPhotoData(data: data)
        UserDefaultsStorage.updateCurrentItem(item: item)
        model.photoSelected()
    }
}



