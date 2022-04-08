//
//  GalleryModel.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 27.03.2022.
//

protocol AlbumFetchable {
    func fetchAlbumData()
}

protocol AlbumRemovable {
    func removeAlbumRecords()
}

protocol AuthRemovable {
    func removeAuthRecords()
}

protocol GalleryModelProtocol: AnyObject, AlbumFetchable, AlbumRemovable, AuthRemovable {
    var dataSource: GalleryCollectionDataSourceProtocol? {get set}
    var delegate: GalleryCollectionDelegateProtocol? {get set}
    var prefetchDataSource: GalleryCollectionDataSourcePrefetchProtocol? {get set}
    func showPhotoViewController()
}

class GalleryModel: GalleryModelProtocol {

    let presenter: GalleryPresenterProtocol
    var dataSource: GalleryCollectionDataSourceProtocol?
    var delegate: GalleryCollectionDelegateProtocol?
    var prefetchDataSource: GalleryCollectionDataSourcePrefetchProtocol?

    init(presenter: GalleryPresenterProtocol,
         dataSource: GalleryCollectionDataSourceProtocol,
         prefetchDataSource: GalleryCollectionDataSourcePrefetchProtocol,
         delegate: GalleryCollectionDelegateProtocol) {
        self.presenter = presenter
        self.dataSource = dataSource
        self.prefetchDataSource = prefetchDataSource
        self.delegate = delegate
    }

    func fetchAlbumData() {
        NetworkService.shared.getAlbumData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let album):
                guard let dataSource = self.dataSource,
                      let delegate = self.delegate,
                      let prefetchDataSource = self.prefetchDataSource else {
                    return
                }
                dataSource.album = album
                delegate.album = album
                prefetchDataSource.album = album
                UserDefaultsStorage.updateAlbumData(album: album)
                self.presenter.reloadCollectionView()
            case .failure(let error):
                self.handleGetAlbumError(error: error)
            }
        }
    }

    func showPhotoViewController() {
        presenter.showPhotoViewController()
    }

    func removeAuthRecords() {
        UserDefaultsStorage.deleteCode()
        UserDefaultsStorage.deleteCurrentToken()
        UserDefaultsStorage.updateIsTokenActual(with: false)
    }

    func removeAlbumRecords() {
        UserDefaultsStorage.deleteAlbum()
    }

    private func handleGetAlbumError(error: GetAlbumError) {
        let presenter = presenter as GalleryPresenterAlertable
        switch error {
        case .unknownError:
            presenter.showAlertUnknownError()
        case .error(let error):
            presenter.showAlertError(error: error)
        case .userNotSignedIn:
            presenter.showAlertUserNotSignedIn()
        case .designatedError(let error):
            presenter.showAlertDesignatedError(error: error)
        }
    }
}
