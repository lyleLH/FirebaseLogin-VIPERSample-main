//
//  RecordPresenter.swift
//  
//
//  Created by Tom.Liu on .
//
//

import Foundation

protocol RecordPresenterProtocol: AnyObject {
    func notifySignInTapped()
    func notifySignUpTapped()
}

class RecordPresenter: RecordPresenterProtocol {
    weak var view: RecordViewProtocol?
    var router: RecordRouterProtocol?
    var interactor: RecordInteractorProtocol?
    
    func notifySignInTapped() {
        router?.routeToSignIn(view as! RecordViewController)
    }
    
    func notifySignUpTapped() {
        router?.routeToSignUp(view as! RecordViewController)
    }
}
