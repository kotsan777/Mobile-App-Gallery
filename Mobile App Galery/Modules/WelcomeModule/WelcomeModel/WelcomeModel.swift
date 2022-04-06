//
//  WelcomeModel.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 25.03.2022.
//


protocol WelcomeModelProtocol {
    
}

class WelcomeModel: WelcomeModelProtocol {
    
    let presenter: WelcomePresenterProtocol

    init(presenter: WelcomePresenterProtocol) {
        self.presenter = presenter
    }
}
