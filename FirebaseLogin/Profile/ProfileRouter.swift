//
//  ProfileRouter.swift
//  
//
//  Created by Tom.Liu on .
//
//

import UIKit

typealias ProfileEntry = ProfileViewProtocol & UIViewController

protocol ProfileRouterProtocol {
    var entry: ProfileEntry? { get set }
    func routeToSignIn(_ view: ProfileViewProtocol)
    func routeToSignUp(_ view: ProfileViewProtocol)
}

class ProfileRouter: ProfileRouterProtocol {
    
    var entry: ProfileEntry?
    
    static func createModule() -> ProfileRouterProtocol {
        let view = ProfileViewController()
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        router.entry = view
        
        return router
    }
    
    func routeToSignIn(_ view: ProfileViewProtocol) {
        let signInVC = SignInRouter.createModule()
        guard let view = view as? UIViewController else { return }
        view.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    func routeToSignUp(_ view: ProfileViewProtocol) {
        let signUpVC = SignUpRouter.createModule()
        guard let view = view as? UIViewController else { return }
        view.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
