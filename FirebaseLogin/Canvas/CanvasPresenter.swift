//
//  CanvasPresenter.swift
//  
//
//  Created by Tom.Liu on .
//
//

import Foundation

protocol CanvasPresenterProtocol: AnyObject {
    func notifySignInTapped()
    func notifySignUpTapped()
}

class CanvasPresenter: CanvasPresenterProtocol {
    weak var view: CanvasViewProtocol?
    var router: CanvasRouterProtocol?
    var interactor: CanvasInteractorProtocol?
    
    func notifySignInTapped() {
        router?.routeToSignIn(view as! CanvasViewController)
    }
    
    func notifySignUpTapped() {
        router?.routeToSignUp(view as! CanvasViewController)
    }
}
