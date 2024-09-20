//
//  RecordRouter.swift
//  
//
//  Created by Tom.Liu on .
//
//

import UIKit

typealias RecordEntry = RecordViewProtocol & UIViewController

protocol RecordRouterProtocol {
    var entry: RecordEntry? { get set }
    func routeToSignIn(_ view: RecordViewProtocol)
    func routeToSignUp(_ view: RecordViewProtocol)
}

class RecordRouter: RecordRouterProtocol {
    
    var entry: RecordEntry?
    
    static func createModule() -> RecordRouterProtocol {
        let view = RecordViewController()
        let interactor = RecordInteractor()
        let presenter = RecordPresenter()
        let router = RecordRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        router.entry = view
        
        return router
    }
    
    func routeToSignIn(_ view: RecordViewProtocol) {
        let signInVC = SignInRouter.createModule().viewController
        guard let view = view as? UIViewController else { return }
        view.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    func routeToSignUp(_ view: RecordViewProtocol) {
        let signUpVC = SignUpRouter.createModule()
        guard let view = view as? UIViewController else { return }
        view.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
