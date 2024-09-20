//
//  SignInPresenter.swift
//  FirebaseLogin
//
//  Created by Sezgin on 1.05.2022.
//

import Foundation

import UIKit

protocol SignInPresenterProtocol: AnyObject {
    func notifyDidButtonTapped(username: String, password: String)
    func notifyOauth2LoginUserButtonTapped()

//    func signInSuccess()
//    func signInNotSuccess()
}

class SignInPresenter: SignInPresenterProtocol {
    
    
    func notifyOauth2LoginUserButtonTapped() {
        Task {
            do {
                if let _ = try await interactor?.didLoginByOauth2() {
                    view?.updateWithSuccess()
                    router?.routeToMain()
                }
            } catch {
                view?.updateWithNotSuccess()
            }
        }
        
    }
    
    weak var view: SignInViewControllerProtocol?
    var router: SignInRouterProtocol?
    var interactor: SignInInteractorProtocol?
    
    init(router: SignInRouterProtocol? = nil, interactor: SignInInteractorProtocol? = nil) {
        self.view = router?.viewController as? any SignInViewControllerProtocol
        self.router = router
        self.interactor = interactor
    }
    
    func notifyDidButtonTapped(username: String, password: String) {
        Task {
            
            do {
                if (try await interactor?.didFetchUser(username: username, password: password)) != nil  {
                    view?.updateWithSuccess()
                    router?.routeToMain()
                }
            } catch {
                view?.updateWithNotSuccess()
            }
        }
    }
    
}
