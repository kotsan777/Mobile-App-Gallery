//
//  AuthPresenter.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit
import WebKit

protocol AuthPresenterProtocol {
    func setupDelegate(to webView: WKWebView)
    func setupWebView(_ webView: WKWebView)
    func tokenReceived()
    func showAlertError(error: Error)
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

    func setupWebView(_ webView: WKWebView) {
        model.setupWebView(webView)
    }

    func tokenReceived() {
        view.tokenReceived()
    }

    func showAlertError(error: Error) {
        view.showAlertError(error: error)
    }
}
