//
//  WelcomePresenter.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 25.03.2022.
//

import UIKit

protocol WelcomePresenterProtocol {

}

class WelcomePresenter: WelcomePresenterProtocol {

    var model: WelcomeModelProtocol!
    let view: WelcomeViewControllerProtocol

    init(view: WelcomeViewControllerProtocol) {
        self.view = view
    }
}
