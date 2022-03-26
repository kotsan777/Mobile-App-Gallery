//
//  WelcomeModel.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 25.03.2022.
//

import UIKit
import WebKit

protocol WelcomeModelProtocol {
    func showAuthWebView()
    func generateGalleryViewController()
}

class WelcomeModel: WelcomeModelProtocol {
    
    let presenter: WelcomePresenterProtocol

    init(presenter: WelcomePresenterProtocol) {
        self.presenter = presenter
    }

    func showAuthWebView() {
        let vc = AuthViewController(nibName: "AuthViewController", bundle: nil)
        presenter.showAuthWebView(with: vc)
    }

    func generateGalleryViewController() {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        presenter.showGalleryViewController(vc)
    }
}
