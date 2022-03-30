//
//  Constants.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit

enum GetPhotoRequestConstants {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let path = "/method/photos.get"
    static let ownerIdKey = "owner_id"
    static let ownerIdValue = "-128666765"
    static let albumIdKey = "album_id"
    static let albumIdValue = "266276915"
    static let tokenKey = "access_token"
    static let versionKey = "v"
    static let versionValue = "5.131"
}

enum AuthRequestConstants {
    static let scheme = "https"
    static let host = "oauth.vk.com"
    static let path = "/authorize"
    static let clientIdKey = "client_id"
    static let clientIdValue = "8115695"
    static let displayKey = "display"
    static let displayValue = "mobile"
    static let redirectUriKey = "redirect_uri"
    static let redirectUriValue = "https://oauth.vk.com/blank.html"
    static let responseTypeKey = "response_type"
    static let responseTypeValue = "token"
}

enum GetAlbumResult {
    case success(album: Album)
    case failure(_ error: GetAlbumError)
}

enum GetAlbumError: Error {
    case unknownError
    case designatedError(_ error: DesignatedError)
    case error(_ error: Error)
    case userNotSignedIn
}

enum GalleryFlowLayoutConstants {
    static let minimumLineSpacing: CGFloat = 2
    static let minimumInteritemSpacing: CGFloat = 2
    static let topInset: CGFloat = 0
    static let horizontalWidthDevider: CGFloat = 3
    static let verticalWidthDevider: CGFloat = 2
    static var horizontalSubtracted: CGFloat {
        (horizontalWidthDevider > 2) ? minimumLineSpacing : minimumLineSpacing / 2
    }
    static var verticalSubtracted: CGFloat {
        (verticalWidthDevider > 2) ? minimumInteritemSpacing : minimumInteritemSpacing / 2
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
    static let shareImage: UIImage? = UIImage(systemName: "square.and.arrow.up")
}

enum NibNames {
    static let welcomeViewController = "WelcomeViewController"
    static let authViewController = "AuthViewController"
    static let galleryCollectionViewController = "GalleryCollectionViewController"
    static let galleryCollectionViewCell = "GalleryCollectionViewCell"
    static let photoViewController = "PhotoViewController"
    static let photoCollectionViewCell = "PhotoCollectionViewCell"
}
