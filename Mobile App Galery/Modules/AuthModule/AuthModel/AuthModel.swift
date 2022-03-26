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

    private func getToken(codeValue: String) {
        NetworkService.shared.getAccessToken(code: codeValue) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let token):
                UserDefaultsStorage.saveToken(token: token)
                UserDefaultsStorage.setIsTokenActual(with: true)
                DispatchQueue.main.async {
                    self.presenter.tokenReceived()
                }
            case .failure(let error):
                self.handleError(error: error)
                UserDefaultsStorage.setIsTokenActual(with: false)
            }
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
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url, let codeValue = url.anchorValueOf("code")else {
            return
        }
        getToken(codeValue: codeValue)
    }
}
