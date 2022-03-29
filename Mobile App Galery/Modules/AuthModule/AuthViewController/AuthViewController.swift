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
    func showAlertUnknownError()
    func showAlertFailDecode()
    func showAlertError(error: Error)
    func showAlertSpecialError(error: DesignatedError)
}

class AuthViewController: UIViewController, AuthViewControllerProtocol {

    let configurator = AuthConfigurator()
    var presenter: AuthPresenterProtocol!

    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(view: self)
        setupDelegate(webView: webView)
        setupWebView(webView: webView)
    }

    func tokenReceived() {
        guard let navigationController = presentingViewController as? UINavigationController,
              let welcomeVC = navigationController.topViewController as? WelcomeViewControllerProtocol else {
            return
        }
        welcomeVC.authSucceeded()
        dismiss(animated: true)
    }

    func showAlertUnknownError() {
        let alert = UIAlertController(config: .unknownError)
        present(alert, animated: true)
    }

    func showAlertFailDecode() {
        let alert = UIAlertController(config: .failedDecodeData)
        present(alert, animated: true)
    }

    func showAlertError(error: Error) {
        let alert = UIAlertController(config: .error(error))
        present(alert, animated: true)
    }

    func showAlertSpecialError(error: DesignatedError) {
        let alert = UIAlertController(config: .specialError(error))
        present(alert, animated: true)
    }

    private func setupDelegate(webView: WKWebView) {
        presenter.setupDelegate(to: webView)
    }

    private func setupWebView(webView: WKWebView) {
        presenter.setupWebView(webView)
    }
}
