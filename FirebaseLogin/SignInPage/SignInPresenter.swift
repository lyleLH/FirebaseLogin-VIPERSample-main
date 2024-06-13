//
//  SignInPresenter.swift
//  FirebaseLogin
//
//  Created by Sezgin on 1.05.2022.
//

import Foundation

protocol SignInPresenterProtocol: AnyObject {
    func notifyDidButtonTapped(username: String, password: String)
    func notifyOauth2LoginUserButtonTapped()

    func signInSuccess()
    func signInNotSuccess()
    func routeToMain()
}

class SignInPresenter: SignInPresenterProtocol {
    func notifyOauth2LoginUserButtonTapped() {
        interactor?.didLoginByOauth2()

    }
    
    
    weak var view: SignInViewControllerProtocol?
    var router: SignInRouterProtocol?
    var interactor: SignInInteractorProtocol?
    
    func notifyDidButtonTapped(username: String, password: String) {
        interactor?.didFetchUser(username: username, password: password)
    }
    
    func signInSuccess() {
        view?.updateWithSuccess()
    }
    
    func signInNotSuccess() {
        view?.updateWithNotSuccess()
    }
    
    func routeToMain() {
        router?.routeToMain()
    }
}
