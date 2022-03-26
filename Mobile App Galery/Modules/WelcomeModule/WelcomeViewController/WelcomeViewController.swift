//
//  WelcomeViewController.swift
//  VK-OAuth-App
//
//  Created by Аслан Кутумбаев on 25.03.2022.
//

import UIKit

protocol WelcomeViewControllerProtocol: UIViewController {
    func showAuthWebView(with vc: UIViewController)
    func authSucceeded()
    func showGalleryViewController(_ galleryVC: UIViewController)
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
        setupLabel(label: label)
    }

    func showAuthWebView(with vc: UIViewController) {
        present(vc, animated: true, completion: nil)
    }

    func authSucceeded() {
        presenter.generateGalleryViewController()
    }

    func showGalleryViewController(_ galleryVC: UIViewController) {
        navigationController?.pushViewController(galleryVC, animated: false)
    }

    private func setupButton(button: UIView) {
        button.layer.cornerRadius = 8
    }

    private func setupLabel(label: UILabel) {
        label.text = "Mobile Up \nGallery"
    }
}
