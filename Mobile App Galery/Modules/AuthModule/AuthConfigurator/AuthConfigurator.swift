//
//  AuthConfigurator.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.

protocol AuthConfiguratorProtocol {
    func configure(view: AuthViewController)
}

class AuthConfigurator: AuthConfiguratorProtocol {
    func configure(view: AuthViewController) {
        let presenter: AuthPresenterProtocol = AuthPresenter(view: view)
        let model: AuthModelProtocol = AuthModel(presenter: presenter)
        let webKitDelegate: AuthWebKitDelegateProtocol = AuthWebKitDelegate(model: model)
        
        view.presenter = presenter
        presenter.model = model
        model.authWebKitDelegate = webKitDelegate
        view.webView.navigationDelegate = webKitDelegate
    }
}

