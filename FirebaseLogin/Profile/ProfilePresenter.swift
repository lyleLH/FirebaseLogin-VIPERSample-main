//
//  ProfilePresenter.swift
//  
//
//  Created by Tom.Liu on .
//
//

import Foundation

protocol ProfilePresenterProtocol: AnyObject {
    func notifySignInTapped()
    func notifySignUpTapped()
}

class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfileViewProtocol?
    var router: ProfileRouterProtocol?
    var interactor: ProfileInteractorProtocol?
    
    func notifySignInTapped() {
        router?.routeToSignIn(view as! ProfileViewController)
    }
    
    func notifySignUpTapped() {
        router?.routeToSignUp(view as! ProfileViewController)
    }
}
