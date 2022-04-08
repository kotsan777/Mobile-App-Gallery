//
//  GalleryPresenter.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 27.03.2022.
//

protocol GalleryPresenterAlertable {
    func showPhotoViewController()
    func showAlertError(error: Error)
    func showAlertUserNotSignedIn()
    func showAlertDesignatedError(error: DesignatedError)
    func showAlertUnknownError()
}

protocol GalleryPresenterProtocol: AnyObject, GalleryPresenterAlertable {
    func fetchAlbumData()
    func reloadCollectionView()
    func removeAuthRecords()
    func removeAlbumRecords()
}

class GalleryPresenter: GalleryPresenterProtocol {

    let view: GalleryCollectionViewControllerProtocol
    var model: GalleryModelProtocol!

    init(view: GalleryCollectionViewControllerProtocol) {
        self.view = view
    }

    func fetchAlbumData() {
        let model = model as AlbumFetchable
        model.fetchAlbumData()
    }

    func reloadCollectionView() {
        view.reloadCollectionView()
    }

    func showAlertError(error: Error) {
        let view = view as GalleryViewAlertable
        view.showAlertError(error: error)
    }

    func showAlertUnknownError() {
        let view = view as GalleryViewAlertable
        view.showAlertUnknownError()
    }

    func showAlertUserNotSignedIn() {
        let view = view as GalleryViewAlertable
        view.showAlertUserNotSignedIn()
    }

    func showAlertDesignatedError(error: DesignatedError) {
        let view = view as GalleryViewAlertable
        view.showAlertDesignatedError(error: error)
    }

    func showPhotoViewController() {
        view.showPhotoViewController()
    }

    func removeAuthRecords() {
        let model = model as AuthRemovable
        model.removeAuthRecords()
    }

    func removeAlbumRecords() {
        let model = model as AlbumRemovable
        model.removeAlbumRecords()
    }
}
