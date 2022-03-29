//
//  GalleryModel.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 27.03.2022.
//

import UIKit

protocol GalleryModelProtocol {
    func registerCell(for collectionView: UICollectionView)
    func setupCollectionViewDelegate(for collectionView: UICollectionView)
    func setupCollectionViewDataSource(for collectionView: UICollectionView)
    func setupPrefetchDataSource(for collectionView: UICollectionView)
    func updateCollectionViewLayout(layout: UICollectionViewFlowLayout, with safeAreaLayoutGuide: UILayoutGuide)
    func fetchAlbumData()
}

class GalleryModel: NSObject, GalleryModelProtocol {

    let presenter: GalleryPresenterProtocol
    var album: Album?

    init(presenter: GalleryPresenterProtocol) {
        self.presenter = presenter
    }

    func registerCell(for collectionView: UICollectionView) {
        let nib = UINib(nibName: NibNames.galleryCollectionViewCell, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier)
    }

    func setupCollectionViewDelegate(for collectionView: UICollectionView) {
        collectionView.delegate = self
    }

    func setupCollectionViewDataSource(for collectionView: UICollectionView) {
        collectionView.dataSource = self
    }

    func setupPrefetchDataSource(for collectionView: UICollectionView) {
        collectionView.prefetchDataSource = self
    }

    func updateCollectionViewLayout(layout: UICollectionViewFlowLayout, with safeAreaLayoutGuide: UILayoutGuide) {
        guard let insets = safeAreaLayoutGuide.owningView?.safeAreaInsets else {
            return
        }
        let safeAreaFrame = safeAreaLayoutGuide.layoutFrame
        let side: CGFloat
        if safeAreaFrame.width < safeAreaFrame.height {
            side = (safeAreaFrame.width / GalleryFlowLayoutConstants.verticalWidthDevider) - GalleryFlowLayoutConstants.verticalSubtracted

        } else {
            side = (safeAreaFrame.width / GalleryFlowLayoutConstants.horizontalWidthDevider) - GalleryFlowLayoutConstants.horizontalSubtracted
        }
        layout.itemSize = CGSize(width: side, height: side)
        layout.sectionInset = insets
        layout.sectionInset.top = GalleryFlowLayoutConstants.topInset
        layout.minimumLineSpacing = GalleryFlowLayoutConstants.minimumLineSpacing
        layout.minimumInteritemSpacing = GalleryFlowLayoutConstants.minimumLineSpacing
    }

    func fetchAlbumData() {
        NetworkService.shared.getAlbumData { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let album):
                self.album = album
                UserDefaultsStorage.saveAlbumData(album: album)
                self.presenter.reloadCollectionView()
            case .failure(let error):
                self.handleGetAlbumError(error: error)
            }
        }
    }

    private func handleGetAlbumError(error: GetAlbumError) {
        switch error {
        case .unknownError:
            presenter.showAlertUnknownError()
        case .accessToAlbumFailed:
            presenter.showAlertAccessFailed()
        case .error(let error):
            presenter.showAlertError(error: error)
        case .dataIsEmpty:
            presenter.showAlertDataIsEmpty()
        }
    }

    private func handleGetImageError(error: GetImageError) {
        switch error {
        case .unknownError:
            presenter.showAlertUnknownError()
        case .decodeDataError:
            presenter.showAlertParsImageError()
        case .dataIsEmpty:
            presenter.showAlertDataIsEmpty()
        case .error(let error):
            presenter.showAlertError(error: error)
        }
    }
}

extension GalleryModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {

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
        guard let album = album else {
            return UICollectionViewCell()
        }
        guard let imageURL = album.response.items[indexPath.row][.w]?.url else {
            return UICollectionViewCell()
        }
        NetworkService.shared.getImage(with: imageURL) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let image):
                cell.imageView.image = image
            case .failure(let error):
                self.handleGetImageError(error: error)
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier, for: indexPath) as? GalleryCollectionViewCell else {
                return
            }
            guard let album = album, let imageURL = album.response.items[indexPath.row][.w]?.url else {
                return
            }
            NetworkService.shared.getImage(with: imageURL) { result in
                switch result {
                case .success(let image):
                    cell.imageView.image = image
                case .failure:
                    break
                }
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let currentItem = album?.response.items[indexPath.row],
              let cell = collectionView.cellForItem(at: indexPath) as? GalleryCollectionViewCell,
              let data = cell.imageView.image?.pngData()else {
            return
        }
        UserDefaultsStorage.saveCurrentPhoto(item: currentItem, data: data)
        let photoViewController = PhotoViewController(nibName: NibNames.photoViewController, bundle: nil)
        presenter.showPhotoViewController(photoViewController)
    }
}
