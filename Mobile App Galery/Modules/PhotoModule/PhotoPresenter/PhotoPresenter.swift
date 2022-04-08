//
//  PhotoPresenter.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 29.03.2022.
//

protocol PhotoPresenterProtocol {
    func getAlbum()
    func reloadData()
    func updateCurrentTitle()
    func updateCurrentImage()
    func removePhotoRecords()
    func removeDateRecords()
}

class PhotoPresenter: PhotoPresenterProtocol {
    
    var model: PhotoModelProtocol!
    let view: PhotoViewControllerProtocol

    init(view: PhotoViewControllerProtocol) {
        self.view = view
    }

    func getAlbum() {
        model.getAlbum()
    }

    func reloadData() {
        view.reloadData()
    }

    func updateCurrentTitle() {
        view.updateCurrentTitle()
    }

    func updateCurrentImage() {
        view.updateCurrentImage()
    }

    func removePhotoRecords() {
        model.removePhotoRecords()
    }

    func removeDateRecords() {
        model.removeDateRecords()
    }
}
