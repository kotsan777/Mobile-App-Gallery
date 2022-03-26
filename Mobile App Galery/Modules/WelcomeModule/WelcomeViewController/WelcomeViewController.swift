//
//  WelcomeViewController.swift
//  VK-OAuth-App
//
//  Created by Аслан Кутумбаев on 25.03.2022.
//

import UIKit

protocol WelcomeViewControllerProtocol {
    func showAuthWebView(with vc: UIViewController)
}

class WelcomeViewController: UIViewController, WelcomeViewControllerProtocol {

    let configurator = WelcomeConfigurator()
    var presenter: WelcomePresenterProtocol!

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var authButton: UIButton!

    @IBAction func authButtonTapped() {
        presenter.authButtonTapped()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(view: self)
        setupButton(button: authButton)
    }

    func showAuthWebView(with vc: UIViewController) {
        present(vc, animated: true, completion: nil)
    }

    private func setupButton(button: UIView) {
        button.layer.cornerRadius = 8
    }
}
