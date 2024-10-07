//
//  TrainingAssembly.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/10/7.
//

import Swinject
 
final class TraningAssembly: Assembly {
    
    func assemble(container: Swinject.Container) {
        
        container.register(TrainingInteractorProtocol.self) { _ in
            return TrainingInteractor()
        }
        
        container.register(TrainingRouter.self) { (_, view: TrainingViewController) in
            return TrainingRouter(entry: view as TrainingEntry)
        }
        
        container.register(TrainingPresenter.self) { (_, view: TrainingViewController) in
            guard let router = container.resolve(TrainingRouter.self, argument: view) else {
                fatalError("TrainingRouter dependency could not be resolved")
            }
            guard let interactor = container.resolve(TrainingInteractorProtocol.self) else {
                fatalError("TrainingInteractor dependency could not be resolved")
            }
            return TrainingPresenter(router: router, interactor: interactor)
        }
        
        container.register(TrainingViewController.self) { (_) in
            let view = TrainingViewController()
            guard let presenter = container.resolve(TrainingPresenter.self, argument: view) else {
                fatalError("CreationPresenter dependency could not be resolved")
            }
            view.presenter = presenter
            return view
        }
    }
    
}
