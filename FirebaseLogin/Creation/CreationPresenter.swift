//
//  CreationPresenter.swift
//
//
//  Created by Tom.Liu on .
//
//

import Foundation

protocol CreationModuleProtocol: AnyObject {
    func backToCreationFromTraining()
}

protocol CreationPresenterProtocol: AnyObject, CreationModuleProtocol {
 
    func notifyDidClicked(action: WorkoutAction, group: WorkoutGroup, sectionIndex: Int)
    
    func notifyViewDidLoad()
    func notifyCheckActionSelectionStatus(action: WorkoutAction) -> Bool
    func notifyCheckIsHaveSelections() -> Bool

    func notifyRouteToTrainingPage()

}

class CreationPresenter: CreationPresenterProtocol {
    
    private weak var view: CreationViewProtocol?
    private var router: CreationRouterProtocol
    private var interactor: CreationInteractorProtocol
    
    init(view: CreationViewProtocol? = nil, router: CreationRouterProtocol, interactor: CreationInteractorProtocol) {
        
        self.router = router
        self.view = router.viewController as? any CreationViewProtocol
        self.interactor = interactor
    }
    
    func notifyViewDidLoad() {
        view?.updateSectionViewData(sections: interactor.fetchSectionsData())   
    }
    
    func notifyDidClicked(action: WorkoutAction, group: WorkoutGroup, sectionIndex: Int) {
        _ = interactor.addOrRemoveAnAction(action: action, group: group)
        
        view?.reloadSectionView(indexPath: IndexPath(row: 0, section: sectionIndex))
    }
    
    func notifyCheckIsHaveSelections() -> Bool {
        return interactor.haveSelection() == true
    }
    
    func notifyRouteToTrainingPage() {
        if let view = view {
            let actions = interactor.getSelectedActions()
            router.routeToTraining(view, selections: actions )
            
        }
    }
    
    func notifyCheckActionSelectionStatus(action: WorkoutAction) -> Bool {
        return interactor.isActionSelected(action: action) == true
    }
  
    func backToCreationFromTraining() {
        notifyViewDidLoad()
        view?.showActionButton()
    }
    
}
