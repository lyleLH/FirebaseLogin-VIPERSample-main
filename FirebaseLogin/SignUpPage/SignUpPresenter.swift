//
//  SignUpPresenter.swift
//  FirebaseLogin
//
//  Created by Sezgin on 2.05.2022.
//

import Foundation

protocol SignUpPresenterProtocol: AnyObject {
    func notifyCreateUserButtonTapped(username: String, password: String)
    func notifyOauth2CreateUserButtonTapped()

    func userCreateNotSuccess()
    func userCreateSuccess()
    func routeToMain()
}

class SignUpPresenter: SignUpPresenterProtocol {
    func notifyOauth2CreateUserButtonTapped() {
        interactor?.didOpenAuth2CreateUser()
    }
    
    weak var view: SignUpViewProtocol?
    var interactor: SignUpInteractorProtocol?
    var router: SignUpRouterProtocol?
    
    func notifyCreateUserButtonTapped(username: String, password: String) {
        interactor?.didCreateUser(username: username, password: password)
    }
    
    func userCreateSuccess() {
        view?.userCreated()
    }
    
    func userCreateNotSuccess() {
        view?.userNotCreated()
    }
    
    func routeToMain() {
        router?.routeToMain()
    }
}
