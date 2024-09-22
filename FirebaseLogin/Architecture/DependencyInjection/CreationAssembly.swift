//
//  CreationAssembly.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/9/20.
//

import Swinject
 
final class CreationAssembly: Assembly {
    
    func assemble(container: Swinject.Container) {
        
        container.register(CreationInteractorProtocol.self) { _ in
            return CreationInteractor()
        }
        
        container.register(CreationRouter.self) { (_, view: CreationViewController) in
             return CreationRouter(viewController: view)
        }
        
        container.register(CreationPresenter.self) { (_, view: CreationViewController) in
            guard let router = container.resolve(CreationRouter.self, argument: view) else {
                fatalError("CreationRouter dependency could not be resolved")
            }
            guard let interactor = container.resolve(CreationInteractorProtocol.self) else {
                fatalError("CreationInteractor dependency could not be resolved")
            }
            return CreationPresenter(router: router, interactor: interactor)
        }
        
        container.register(CreationViewController.self) { (_) in
            let view = CreationViewController()
            guard let presenter = container.resolve(CreationPresenter.self, argument: view) else {
                fatalError("CreationPresenter dependency could not be resolved")
            }
            view.presenter = presenter
            return view
        }
    }
    
}
