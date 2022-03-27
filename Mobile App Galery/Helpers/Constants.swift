//
//  Constants.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit

enum GetTokenResult {
    case success(token: Token)
    case failure(_ eror: GetTokenError)
}

enum GetAlbumResult {
    case success(album: Album)
    case failure(_ error: GetAlbumError)
}

enum GetImageResult {
    case success(image: UIImage)
    case failure(_ error: GetImageError)
}

enum GetTokenError: Error {
    case unknownError
    case failDecodeData
    case error(_ error: Error)
    case specialError(_ error: DesignatedError)
}

enum GetAlbumError: Error {
    case unknownError
    case accessToAlbumFailed
    case error(_ error: Error)
    case dataIsEmpty
}

enum GetImageError: Error {
    case unknownError
    case decodeDataError
    case dataIsEmpty
    case error(_ error: Error)
}

enum GalleryFlowLayoutConstants {
    static let minimumLineSpacing: CGFloat = 2
    static let minimumInteritemSpacing: CGFloat = 2
    static let topInset: CGFloat = 0
    static let horizontalWidthDevider: CGFloat = 4
    static let verticalWidthDevider: CGFloat = 3
    static var horizontalSubtracted: CGFloat {
        (horizontalWidthDevider > 2) ? minimumLineSpacing : minimumLineSpacing / 2
    }
    static var verticalSubtracted: CGFloat {
        (verticalWidthDevider > 2) ? minimumInteritemSpacing : minimumInteritemSpacing / 2
    }
}
