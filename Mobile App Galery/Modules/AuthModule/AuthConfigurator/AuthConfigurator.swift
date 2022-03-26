//
//  AuthConfigurator.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.

import UIKit

protocol AuthConfiguratorProtocol {
    func configure(view: AuthViewController)
}

class AuthConfigurator: AuthConfiguratorProtocol {
    func configure(view: AuthViewController) {
        let presenter = AuthPresenter(view: view)
        let model = AuthModel(presenter: presenter)
        view.presenter = presenter
        presenter.model = model
    }
}

