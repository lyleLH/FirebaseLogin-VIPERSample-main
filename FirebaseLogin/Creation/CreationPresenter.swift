//
//  CreationPresenter.swift
//
//
//  Created by Tom.Liu on .
//
//

import Foundation

protocol CreationPresenterProtocol: AnyObject {
    func notifySignInTapped()
    func notifySignUpTapped()
    
    func notifyDidClicked(action: WorkoutAction, group: WorkoutGroup, section: WorkoutSection)
    
    func notifyViewDidLoad()
    func notifyCheckActionSelectionStatus(action: WorkoutAction) -> Bool
}

class CreationPresenter: CreationPresenterProtocol {
    func notifyCheckActionSelectionStatus(action: WorkoutAction) -> Bool {
        return interactor?.isActionSelected(action: action) == true
    }
    
  
    
    
 
    
    weak var view: CreationViewProtocol?
    var router: CreationRouterProtocol?
    var interactor: CreationInteractorProtocol?
    
    func notifySignInTapped() {
        router?.routeToSignIn(view as! CreationViewController)
    }
    
    func notifySignUpTapped() {
        router?.routeToSignUp(view as! CreationViewController)
    }
    
    
    func notifyViewDidLoad() {
        
        if let sections = interactor?.fetchSectionsData() {
            view?.updateSectionViewData(sections: sections)
        }
        
    }
    
    func notifyDidClicked(action: WorkoutAction, group: WorkoutGroup, section: WorkoutSection) {
        _ = interactor?.addOrRemoveAnAction(action: action, group: group)
        
        if let section = interactor?.getAllSections().firstIndex(where: { tSection in
            tSection.title == section.title
        }) {
            view?.reloadSectionView(indexPath: IndexPath(row: 0, section: section))
        }
        
    }
    
    
}
