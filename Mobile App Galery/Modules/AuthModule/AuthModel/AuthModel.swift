//
//  AuthModel.swift
//  Mobile App Galery
//
//  Created by Аслан Кутумбаев on 26.03.2022.
//

protocol AuthModelProtocol: AnyObject {
    var authWebKitDelegate: AuthWebKitDelegateProtocol? {get set}
    func codeReceived()
    func showAlertError(error: Error)
}

class AuthModel: AuthModelProtocol {

    let presenter: AuthPresenterProtocol
    var authWebKitDelegate: AuthWebKitDelegateProtocol?

    init(presenter: AuthPresenterProtocol) {
        self.presenter = presenter
    }

    func codeReceived() {
        NetworkService.shared.getToken { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let token):
                UserDefaultsStorage.updateToken(token: token)
                UserDefaultsStorage.updateIsTokenActual(with: true)
                self.presenter.tokenReceived()
            case .failure(let error):
                self.handleGetTokenError(error: error)
            }
        }
    }

    func showAlertError(error: Error) {
        presenter.showAlertError(error: error)
    }

    private func handleGetTokenError(error: GetTokenError) {
        switch error {
        case .unknownError:
            presenter.showAlertUnknownError()
        case .tokenError(let error):
            presenter.showAlertTokenError(error: error)
        case .error(let error):
            presenter.showAlertError(error: error)
        }
    }
}
