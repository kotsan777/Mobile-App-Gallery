//
//  AuthWebKitDelegate.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 31.03.2022.
//

import UIKit
import WebKit

protocol AuthWebKitDelegateProtocol: WKNavigationDelegate {
    var model: AuthModelProtocol {get set}
}

class AuthWebKitDelegate: NSObject, AuthWebKitDelegateProtocol {

    var model: AuthModelProtocol

    init(model: AuthModelProtocol) {
        self.model = model
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        model.showAlertError(error: error)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url, let fragment = url.fragment else {
            return
        }
        let isFragmentContainToken = fragment.contains(URL.QueryParameterType.accessToken)
        isFragmentContainToken ? (getToken(with: url)) : nil
    }

    private func getToken(with url: URL) {
        guard let accessToken = url.queryValue(of: URL.QueryParameterType.accessToken),
              let expriresIn = url.queryValue(of: URL.QueryParameterType.expiresIn),
              let userId = url.queryValue(of: URL.QueryParameterType.userId) else {
            return
        }
        guard let expriresIn = Int(expriresIn), let userId = Int(userId) else {
            return
        }
        let token = Token(accessToken: accessToken, expiresIn: expriresIn, userID: userId)
        UserDefaultsStorage.updateToken(token: token)
        UserDefaultsStorage.updateIsTokenActual(with: true)
        model.tokenReceived()
    }
}
