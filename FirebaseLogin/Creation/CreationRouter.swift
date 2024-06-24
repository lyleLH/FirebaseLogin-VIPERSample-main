//
//  CreationRouter.swift
//  
//
//  Created by Tom.Liu on .
//
//

import UIKit

typealias CreationEntry = CreationViewProtocol & UIViewController

protocol CreationRouterProtocol {
    var entry: CreationEntry? { get set }
    func routeToSignIn(_ view: CreationViewProtocol)
    func routeToSignUp(_ view: CreationViewProtocol)
}

class CreationRouter: CreationRouterProtocol {
    
    var entry: CreationEntry?
    
    static func createModule() -> CreationRouterProtocol {
        let view = CreationViewController()
        let interactor = CreationInteractor()
        let presenter = CreationPresenter()
        let router = CreationRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        router.entry = view
        
        return router
    }
    
    func routeToSignIn(_ view: CreationViewProtocol) {
        let signInVC = SignInRouter.createModule()
        guard let view = view as? UIViewController else { return }
        view.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    func routeToSignUp(_ view: CreationViewProtocol) {
        let signUpVC = SignUpRouter.createModule()
        guard let view = view as? UIViewController else { return }
        view.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
