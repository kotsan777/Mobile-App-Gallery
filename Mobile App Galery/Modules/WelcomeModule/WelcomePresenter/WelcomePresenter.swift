//
//  WelcomePresenter.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 25.03.2022.
//

import UIKit

protocol WelcomePresenterProtocol {
    func authButtonTapped()
    func showAuthWebView(with vc: UIViewController)
}

class WelcomePresenter: WelcomePresenterProtocol {

    var model: WelcomeModelProtocol!
    let view: WelcomeViewControllerProtocol

    init(view: WelcomeViewControllerProtocol) {
        self.view = view
    }

    func authButtonTapped() {
        model.showAuthWebView()
    }

    func showAuthWebView(with vc: UIViewController) {
        view.showAuthWebView(with: vc)
    }
}
