//
//  AuthModel.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import WebKit

protocol AuthModelProtocol: AnyObject {
    func setupDelegate(to webView: WKWebView)
    func updateWebViewPage(_ webView: WKWebView)
    func tokenReceived()
    func showAlertError(error: Error)
}

class AuthModel: AuthModelProtocol {

    let presenter: AuthPresenterProtocol
    var authWebKitDelegate: AuthWebKitDelegateProtocol!

    init(presenter: AuthPresenterProtocol) {
        self.presenter = presenter
    }

    func setupDelegate(to webView: WKWebView) {
        webView.navigationDelegate = authWebKitDelegate
    }

    func updateWebViewPage(_ webView: WKWebView) {
        guard let request = RequestBuilder.getAuthRequest() else {
            return
        }
        webView.load(request)
    }

    func tokenReceived() {
        presenter.tokenReceived()
    }

    func showAlertError(error: Error) {
        presenter.showAlertError(error: error)
    }
}
