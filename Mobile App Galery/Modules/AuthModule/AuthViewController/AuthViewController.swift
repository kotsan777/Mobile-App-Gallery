//
//  AuthViewController.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit
import WebKit

protocol AuthViewControllerProtocol {
    func tokenReceived()
    func showAlertError(error: Error)
    func showAlertUnknownError()
    func showAlertTokenError(error: TokenError)
}

class AuthViewController: UIViewController, AuthViewControllerProtocol {

    let configurator = AuthConfigurator()
    var presenter: AuthPresenterProtocol!

    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(view: self)
        setupDelegate(webView: webView)
        updateWebViewPage(webView)
    }

    func tokenReceived() {
        guard let navigationController = presentingViewController as? UINavigationController,
              let welcomeVC = navigationController.topViewController as? WelcomeViewControllerProtocol else {
            return
        }
        welcomeVC.authSucceeded()
        dismiss(animated: true)
    }

    func showAlertError(error: Error) {
        let alert = UIAlertController(config: .error(error))
        alert.addAction(config: .exit) { [weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        alert.addAction(config: .reload) { [weak self] _ in
            guard let self = self else { return }
            self.presenter.updateWebViewPage(self.webView)
        }
        present(alert, animated: true)
    }

    func showAlertUnknownError() {
        let alert = UIAlertController(config: .unknownError)
        alert.addAction(config: .ok)
        present(alert, animated: true)
    }

    func showAlertTokenError(error: TokenError) {
        let alert = UIAlertController(config: .tokenError(error))
        alert.addAction(config: .ok)
        present(alert, animated: true)
    }

    private func setupDelegate(webView: WKWebView) {
        presenter.setupDelegate(to: webView)
    }

    private func updateWebViewPage(_ webView: WKWebView) {
        presenter.updateWebViewPage(webView)
    }
}
