//
//  AuthModel.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit
import WebKit

protocol AuthModelProtocol {
    func setupDelegate(to webView: WKWebView)
    func setupWebView(_ webView: WKWebView)
}

class AuthModel: NSObject, AuthModelProtocol {

    let presenter: AuthPresenterProtocol

    init(presenter: AuthPresenterProtocol) {
        self.presenter = presenter
    }

    func setupDelegate(to webView: WKWebView) {
        webView.navigationDelegate = self
    }

    func setupWebView(_ webView: WKWebView) {
        guard let request = RequestBuilder.getAuthRequest() else {
            return
        }
        webView.load(request)
    }

    private func getToken(with url: URL) {
        guard let accessToken = url.anchorValueOf("access_token"),
              let expriresIn = url.anchorValueOf("expires_in"),
              let userId = url.anchorValueOf("user_id") else {
                  UserDefaultsStorage.setIsTokenActual(with: false)
                  UserDefaultsStorage.deleteCurrentToken()
            return
        }
        guard let expriresIn = Int(expriresIn), let userId = Int(userId) else {
            return
        }
        let token = Token(accessToken: accessToken, expiresIn: expriresIn, userID: userId)
        UserDefaultsStorage.saveToken(token: token)
        UserDefaultsStorage.setIsTokenActual(with: true)
        DispatchQueue.main.async {
            self.presenter.tokenReceived()
        }
    }

    private func handleError(error: GetTokenError) {
        switch error {
        case .unknownError:
            presenter.showAlertUnknownError()
        case .failDecodeData:
            presenter.showAlertFailDecode()
        case .error(let error):
            presenter.showAlertError(error: error)
        case .specialError(let error):
            presenter.showAlertSpecialError(error: error)
        }
    }
}

extension AuthModel: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let url = webView.url else {
            return
        }
        getToken(with: url)
    }
}
