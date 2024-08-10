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


protocol CreationPresenterProtocol: AnyObject , CreationModuleProtocol {
 
    func notifyDidClicked(action: WorkoutAction, group: WorkoutGroup, sectionIndex: Int)
    
    func notifyViewDidLoad()
    func notifyCheckActionSelectionStatus(action: WorkoutAction) -> Bool
    func notifyCheckIsHaveSelections()-> Bool

    func notifyRouteToTrainingPage()

}

class CreationPresenter: CreationPresenterProtocol {

    
    weak var view: CreationViewProtocol?
    var router: CreationRouterProtocol?
    var interactor: CreationInteractorProtocol?
    

    
    func notifyViewDidLoad() {
        
        if let sections = interactor?.fetchSectionsData() {
            view?.updateSectionViewData(sections: sections)
        }
        
    }
    
    func notifyDidClicked(action: WorkoutAction, group: WorkoutGroup, sectionIndex: Int) {
        _ = interactor?.addOrRemoveAnAction(action: action, group: group)
        
        view?.reloadSectionView(indexPath: IndexPath(row: 0, section: sectionIndex))
    }
    
    func notifyCheckIsHaveSelections() -> Bool {
        return interactor?.haveSelection() == true
    }
    
    func notifyRouteToTrainingPage() {
        if let view = view ,let actions = interactor?.getSelectedActions(){
            router?.routeToTraining(view, selections: actions )
            
        }
    }
    
    func notifyCheckActionSelectionStatus(action: WorkoutAction) -> Bool {
        return interactor?.isActionSelected(action: action) == true
    }
    
  
    func backToCreationFromTraining() {
        notifyViewDidLoad()
        view?.showActionButton()
    }
    
}
