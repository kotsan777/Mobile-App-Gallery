//
//  AuthPresenter.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import WebKit

protocol AuthPresenterProtocol {
    func setupDelegate(to webView: WKWebView)
    func updateWebViewPage(_ webView: WKWebView)
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

    func setupDelegate(to webView: WKWebView) {
        model.setupDelegate(to: webView)
    }

    func updateWebViewPage(_ webView: WKWebView) {
        model.updateWebViewPage(webView)
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
