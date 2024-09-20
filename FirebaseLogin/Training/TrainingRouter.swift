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
    var creationModule: CreationModuleProtocol? { get set }
    var entry: TrainingEntry? { get set }
    func routeToSignIn(_ view: TrainingViewProtocol)
    func routeToSignUp(_ view: TrainingViewProtocol)
    func dissMissTrainingPage()
}

class TrainingRouter: TrainingRouterProtocol {
   weak var creationModule: (any CreationModuleProtocol)?
    
    var entry: TrainingEntry?
    
    static func createModule(from: CreationModuleProtocol) -> TrainingRouterProtocol {
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
        router.creationModule = from
        return router
    }
    
    func routeToSignIn(_ view: TrainingViewProtocol) {
        let signInVC = SignInRouter.createModule().viewController
        guard let view = view as? UIViewController else { return }
        view.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    func routeToSignUp(_ view: TrainingViewProtocol) {
        let signUpVC = SignUpRouter.createModule()
        guard let view = view as? UIViewController else { return }
        view.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func dissMissTrainingPage() {
        self.entry?.dismiss(animated: true)
    }
    
}
