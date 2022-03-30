//
//  UIAlertActionConfiguration.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 30.03.2022.
//

import UIKit

extension UIAlertAction {
    
    enum AlertActionCongiuration {
        case ok
        case cancell
        case reload
        case reLogIn
        case exit
    }

    convenience init(config: AlertActionCongiuration, completion: ((UIAlertAction) -> ())?) {
        switch config {
        case .ok:
            self.init(title: "Ок", style: .default, handler: completion)
        case .cancell:
            self.init(title: "Отмена", style: .default, handler: completion)
        case .reload:
            self.init(title: "Перезагрузить", style: .default, handler: completion)
        case .reLogIn:
            self.init(title: "Перезайти", style: .default, handler: completion)
        case .exit:
            self.init(title: "Выйти", style: .default, handler: completion)
        }
    }
}
