//
//  TrainingRouter.swift
//  
//
//  Created by Tom.Liu on .
//
//

import UIKit

typealias TrainingEntry = TrainingViewProtocol & UIViewController

protocol TrainingRouterProtocol {
    var entry: TrainingEntry? { get set }
    func routeToSignIn(_ view: TrainingViewProtocol)
    func routeToSignUp(_ view: TrainingViewProtocol)
}

class TrainingRouter: TrainingRouterProtocol {
    
    var entry: TrainingEntry?
    
    static func createModule() -> TrainingRouterProtocol {
        let view = TrainingViewController()
        let interactor = TrainingInteractor()
        let presenter = TrainingPresenter()
        let router = TrainingRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        router.entry = view
        
        return router
    }
    
    func routeToSignIn(_ view: TrainingViewProtocol) {
        let signInVC = SignInRouter.createModule()
        guard let view = view as? UIViewController else { return }
        view.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    func routeToSignUp(_ view: TrainingViewProtocol) {
        let signUpVC = SignUpRouter.createModule()
        guard let view = view as? UIViewController else { return }
        view.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
