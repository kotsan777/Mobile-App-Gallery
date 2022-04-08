//
//  PhotoModel.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 29.03.2022.
//

import Foundation

protocol PhotoModelProtocol {
    func getAlbum()
    func photoSelected()
    func removePhotoRecords()
    func removeDateRecords()
}

class PhotoModel: PhotoModelProtocol {

    let presenter: PhotoPresenterProtocol
    var album: Album?
    var delegate: PhotoCollectionDelegateProtocol?
    var dataSource: PhotoCollectionDataSourceProtocol?

    init(presenter: PhotoPresenterProtocol,
         dataSource: PhotoCollectionDataSourceProtocol,
         delegate: PhotoCollectionDelegateProtocol) {
        self.presenter = presenter
        self.dataSource = dataSource
        self.delegate = delegate
    }

    func getAlbum() {
        guard let dataSource = dataSource,
              let delegate = delegate else {
            return
        }
        let album = UserDefaultsStorage.getAlbum()
        dataSource.album = album
        delegate.album = album
        presenter.reloadData()
    }

    func photoSelected() {
        updateTitleInStorage()
        presenter.updateCurrentTitle()
        presenter.updateCurrentImage()
    }

    func removePhotoRecords() {
        UserDefaultsStorage.deleteCurrentPhotoData()
        UserDefaultsStorage.deleteCurrentItem()
    }

    func removeDateRecords() {
        UserDefaultsStorage.deleteCurrentDate()
    }

    private func updateTitleInStorage() {
        guard let item = UserDefaultsStorage.getCurrentItem() else {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let unixDate = item.date
        let date = Date(timeIntervalSince1970: Double(unixDate))
        let rawDateString = dateFormatter.string(from: date)
        let resultString = String(rawDateString.dropLast(3))
        UserDefaultsStorage.updateCurrentDate(date: resultString)
    }
}
