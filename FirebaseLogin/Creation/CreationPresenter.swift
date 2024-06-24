//
//  CreationPresenter.swift
//  
//
//  Created by Tom.Liu on .
//
//

import Foundation

protocol CreationPresenterProtocol: AnyObject {
    func notifySignInTapped()
    func notifySignUpTapped()
}

class CreationPresenter: CreationPresenterProtocol {
    weak var view: CreationViewProtocol?
    var router: CreationRouterProtocol?
    var interactor: CreationInteractorProtocol?
    
    func notifySignInTapped() {
        router?.routeToSignIn(view as! CreationViewController)
    }
    
    func notifySignUpTapped() {
        router?.routeToSignUp(view as! CreationViewController)
    }
}
