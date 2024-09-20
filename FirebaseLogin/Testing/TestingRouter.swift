//
//  TestingRouter.swift
//  
//
//  Created by Tom.Liu on .
//
//

import UIKit

typealias TestingEntry = TestingViewProtocol & UIViewController

protocol TestingRouterProtocol {
    var entry: TestingEntry? { get set }
    func routeToSignIn(_ view: TestingViewProtocol)
    func routeToSignUp(_ view: TestingViewProtocol)
}

class TestingRouter: TestingRouterProtocol {
    
    var entry: TestingEntry?
    
    static func createModule() -> TestingRouterProtocol {
        let view = TestingViewController()
        let interactor = TestingInteractor()
        let presenter = TestingPresenter()
        let router = TestingRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        router.entry = view
        
        return router
    }
    
    func routeToSignIn(_ view: TestingViewProtocol) {
        let signInVC = SignInRouter.createModule().viewController
        guard let view = view as? UIViewController else { return }
        view.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    func routeToSignUp(_ view: TestingViewProtocol) {
        let signUpVC = SignUpRouter.createModule()
        guard let view = view as? UIViewController else { return }
        view.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
