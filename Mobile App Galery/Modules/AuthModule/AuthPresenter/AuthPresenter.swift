//
//  AuthPresenter.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

protocol AuthPresenterProtocol: AnyObject {
    var model: AuthModelProtocol! {get set}
    func tokenReceived()
    func showAlertError(error: Error)
    func showAlertUnknownError()
    func showAlertTokenError(error: TokenError)
}

class AuthPresenter: AuthPresenterProtocol {

    var model: AuthModelProtocol!
    let view: AuthViewControllerProtocol

    init(view: AuthViewControllerProtocol) {
        self.view = view
    }

    func tokenReceived() {
        view.tokenReceived()
    }

    func showAlertError(error: Error) {
        view.showAlertError(error: error)
    }

    func showAlertUnknownError() {
        view.showAlertUnknownError()
    }

    func showAlertTokenError(error: TokenError) {
        view.showAlertTokenError(error: error)
    }
}
