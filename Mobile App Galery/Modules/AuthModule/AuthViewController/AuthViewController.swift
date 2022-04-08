//
//  AuthViewController.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

import UIKit
import WebKit

protocol AuthViewControllerProtocol {
    var webView: WKWebView! {get set}
    func tokenReceived()
    func showAlertError(error: Error)
    func showAlertUnknownError()
    func showAlertTokenError(error: TokenError)
}

class AuthViewController: UIViewController, AuthViewControllerProtocol {

    let configurator: AuthConfiguratorProtocol
    let alertFactory: AlertFactoryProtocol
    var presenter: AuthPresenterProtocol!

    @IBOutlet weak var webView: WKWebView!

    init(configurator: AuthConfiguratorProtocol, alertFactory: AlertFactoryProtocol) {
        self.configurator = configurator
        self.alertFactory = alertFactory
        super.init(nibName: NibNames.authViewController, bundle: nil)
    }

    convenience init() {
        let configurator = AuthConfigurator()
        let alertFactory = AlertFactory()
        self.init(configurator: configurator, alertFactory: alertFactory)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(view: self)
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
        let alert = alertFactory.produce(with: .error(error))
        alert.addAction(config: .exit) { [weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        alert.addAction(config: .reload) { [weak self] _ in
            guard let self = self else { return }
            self.updateWebViewPage(self.webView)
        }
        present(alert, animated: true)
    }

    func showAlertUnknownError() {
        let alert = alertFactory.produce(with: .unknownError)
        alert.addAction(config: .ok)
        present(alert, animated: true)
    }

    func showAlertTokenError(error: TokenError) {
        let alert = alertFactory.produce(with: .tokenError(error))
        alert.addAction(config: .ok)
        present(alert, animated: true)
    }

    private func updateWebViewPage(_ webView: WKWebView) {
        guard let request = RequestBuilder.getAuthRequest() else {
            return
        }
        webView.load(request)
    }
}
