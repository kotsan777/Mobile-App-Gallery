//
//  FlowLayoutConstants.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 31.03.2022.
//

import UIKit

enum GalleryFlowLayoutConstants {

    enum Orientation {
        case vertical
        case horizontal
    }

    static let minimumLineSpacing: CGFloat = 2
    static let minimumInteritemSpacing: CGFloat = 2
    static let topInset: CGFloat = 0

    private static let horizontalWidthDevider: CGFloat = 3
    private static let verticalWidthDevider: CGFloat = 2
    private static var horizontalSubtracted: CGFloat {
        (horizontalWidthDevider > 2) ? minimumLineSpacing : minimumLineSpacing / 2
    }
    private static var verticalSubtracted: CGFloat {
        (verticalWidthDevider > 2) ? minimumInteritemSpacing : minimumInteritemSpacing / 2
    }

    static func getSize(orientation: Orientation, currentWidth: CGFloat) -> CGFloat {
        switch orientation {
        case .vertical:
            let size = (currentWidth / GalleryFlowLayoutConstants.verticalWidthDevider) - GalleryFlowLayoutConstants.verticalSubtracted
            return size
        case .horizontal:
            let size = (currentWidth / GalleryFlowLayoutConstants.horizontalWidthDevider) - GalleryFlowLayoutConstants.horizontalSubtracted
            return size
        }
    }
}

enum PhotoFlowLayoutConstants {
    static let minimumLineSpacing: CGFloat = 2
    static var sideSize: CGFloat = 56
}


enum NavigationControllerConstants {
    static let titleFont: UIFont = .systemFont(ofSize: 18, weight: .semibold)
    static let tintColor: UIColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
    static let galleryViewControllerTitle = "Mobile Up Gallery"
}

enum NavigationButtonItemsConstants {
    static let exitGalleryText: String = "Выход"
    static let exitGalleryFont: UIFont = .systemFont(ofSize: 18, weight: .medium)
    static let shareImage: UIImage? = UIImage(named: "ShareButtonImage")
}
