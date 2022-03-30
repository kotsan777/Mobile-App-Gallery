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
        guard let accessToken = url.queryValue(of: URL.QueryParameterType.accessToken),
              let expriresIn = url.queryValue(of: URL.QueryParameterType.expiresIn),
              let userId = url.queryValue(of: URL.QueryParameterType.userId) else {
            return
        }
        guard let expriresIn = Int(expriresIn), let userId = Int(userId) else {
            return
        }
        let token = Token(accessToken: accessToken, expiresIn: expriresIn, userID: userId)
        UserDefaultsStorage.saveToken(token: token)
        UserDefaultsStorage.setIsTokenActual(with: true)
        presenter.tokenReceived()
        removeWebKitData()
    }

    private func removeWebKitData() {
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
}

extension AuthModel: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        presenter.showAlertError(error: error)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url, let fragment = url.fragment else {
            return
        }
        let isFragmentContainToken = fragment.contains(URL.QueryParameterType.accessToken)
        isFragmentContainToken ? (getToken(with: url)) : nil
    }
}
