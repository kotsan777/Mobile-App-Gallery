//
//  WelcomeConfigurator.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 25.03.2022.
//


protocol WelcomeConfiguratorProtocol {
    func configure(view: WelcomeViewController)
}

class WelcomeConfigurator: WelcomeConfiguratorProtocol {
    func configure(view: WelcomeViewController) {
        let presenter = WelcomePresenter(view: view)
        let model = WelcomeModel(presenter: presenter)
        view.presenter = presenter
        presenter.model = model
    }
}
