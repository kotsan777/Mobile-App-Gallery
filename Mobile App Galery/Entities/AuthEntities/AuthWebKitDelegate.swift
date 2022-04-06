//
//  AuthWebKitDelegate.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 31.03.2022.
//

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

    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url, let fragment = url.fragment else {
            return
        }
        let isFragmentContainCode = fragment.contains(URL.QueryParameterType.code)
        isFragmentContainCode ? (getCode(with: url)) : nil
    }

    private func getCode(with url: URL) {
        guard let code = url.queryValue(of: URL.QueryParameterType.code) else {
            return
        }
        UserDefaultsStorage.updateCode(code: code)
        model.codeReceived()
    }
}
