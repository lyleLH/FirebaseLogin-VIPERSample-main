//
//  CanvasRouter.swift
//  
//
//  Created by Tom.Liu on .
//
//

import UIKit

typealias CanvasEntry = CanvasViewProtocol & UIViewController

protocol CanvasRouterProtocol {
    var entry: CanvasEntry? { get set }
    func routeToSignIn(_ view: CanvasViewProtocol)
    func routeToSignUp(_ view: CanvasViewProtocol)
}

class CanvasRouter: CanvasRouterProtocol {
    
    var entry: CanvasEntry?
    
    static func createModule() -> CanvasRouterProtocol {
        let view = CanvasViewController()
        let interactor = CanvasInteractor()
        let presenter = CanvasPresenter()
        let router = CanvasRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        router.entry = view
        
        return router
    }
    
    func routeToSignIn(_ view: CanvasViewProtocol) {
        let signInVC = SignInRouter.createModule()
        guard let view = view as? UIViewController else { return }
        view.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    func routeToSignUp(_ view: CanvasViewProtocol) {
        let signUpVC = SignUpRouter.createModule()
        guard let view = view as? UIViewController else { return }
        view.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
