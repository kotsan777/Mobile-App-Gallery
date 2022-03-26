//
//  WelcomeModel.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 25.03.2022.
//

import UIKit

protocol WelcomeModelProtocol {
    func showAuthWebView()
}

class WelcomeModel: WelcomeModelProtocol {
    
    let presenter: WelcomePresenterProtocol

    init(presenter: WelcomePresenterProtocol) {
        self.presenter = presenter
    }

    func showAuthWebView() {
        let vc = UIViewController()
        vc.view.backgroundColor = .green
        presenter.showAuthWebView(with: vc)
    }
}
