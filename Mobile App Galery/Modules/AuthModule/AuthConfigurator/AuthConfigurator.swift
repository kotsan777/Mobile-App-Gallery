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
        let presenter = AuthPresenter(view: view)
        let model = AuthModel(presenter: presenter)
        let webKitDelegate = AuthWebKitDelegate(model: model)
        view.presenter = presenter
        presenter.model = model
        model.authWebKitDelegate = webKitDelegate
    }
}

