//
//  TestingPresenter.swift
//  
//
//  Created by Tom.Liu on .
//
//

import Foundation

protocol TestingPresenterProtocol: AnyObject {
    func notifySignInTapped()
    func notifySignUpTapped()
}

class TestingPresenter: TestingPresenterProtocol {
    weak var view: TestingViewProtocol?
    var router: TestingRouterProtocol?
    var interactor: TestingInteractorProtocol?
    
    func notifySignInTapped() {
        router?.routeToSignIn(view as! TestingViewController)
    }
    
    func notifySignUpTapped() {
        router?.routeToSignUp(view as! TestingViewController)
    }
}
