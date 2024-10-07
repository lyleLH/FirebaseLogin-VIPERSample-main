//
//  CreationRouter.swift
//  
//
//  Created by Tom.Liu on .
//
//

import UIKit

protocol CreationRouterProtocol {
    var viewController: UIViewController { get }
    
    func routeToTraining(_ view: CreationViewProtocol, selections: [WorkoutAction])
    
}

class CreationRouter: CreationRouterProtocol {
    
    internal var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    static func createModule() -> CreationRouterProtocol {
        // FIXME: 使用DI 与否 带来的差别
        
        //        let view = CreationViewController()
        //        let interactor = CreationInteractor()
        //        let presenter = CreationPresenter()
        //        let router = CreationRouter()
        //        
        //        view.presenter = presenter
        //        interactor.presenter = presenter
        //        presenter.view = view
        //        presenter.router = router
        //        presenter.interactor = interactor
        //        router.entry = view
        //        router.presenter = presenter
        let view: CreationViewController = DIContainer.shared.resolve()
        let router: CreationRouter = DIContainer.shared.resolve(argument: view)
        return router
    }
    
    func routeToTraining(_ view: CreationViewProtocol, selections: [WorkoutAction]) {
        
        guard let trainingVC = TrainingRouter.createModule().entry else { return  }
        
        guard let view = view as? UIViewController else { return }
        let trainingNaviVc = MTNavigationViewController(rootViewController: trainingVC)
        trainingNaviVc.modalPresentationStyle = .fullScreen
        trainingNaviVc.addCloseItem()
        view.present(trainingNaviVc, animated: true)
    }
    
}
