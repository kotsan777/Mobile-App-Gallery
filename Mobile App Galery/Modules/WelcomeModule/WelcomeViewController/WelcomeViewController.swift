//
//  WelcomeViewController.swift
//  VK-OAuth-App
//
//  Created by Аслан Кутумбаев on 25.03.2022.
//

import UIKit

protocol WelcomeViewControllerProtocol: UIViewController {
    func authSucceeded()
}

class WelcomeViewController: UIViewController, WelcomeViewControllerProtocol {

    let configurator = WelcomeConfigurator()
    var presenter: WelcomePresenterProtocol!

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var authButton: UIButton!

    @IBAction func authButtonTapped() {
        let vc = AuthViewController()
        present(vc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(view: self)
    }

    func authSucceeded() {
        let vc = GalleryCollectionViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
