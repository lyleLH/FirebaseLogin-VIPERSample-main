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
    func routeToTraining(_ view: CreationViewProtocol, selections: [WorkoutAction])

}

class CreationRouter: CreationRouterProtocol {
    
    var entry: CreationEntry?
    weak var presenter: CreationPresenter?
    
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
        router.presenter = presenter
        
        return router
    }
    
    func routeToTraining(_ view: CreationViewProtocol, selections: [WorkoutAction]) {
        guard let presenter = presenter, let trainingVC = TrainingRouter.createModule(from: presenter).entry else { return  }
        guard let view = view as? UIViewController else { return }
        let trainingNaviVc = MTNavigationViewController(rootViewController: trainingVC)
        trainingNaviVc.modalPresentationStyle = .fullScreen
        trainingNaviVc.addCloseItem()
        view.present(trainingNaviVc, animated: true)
    }
    
  
}
