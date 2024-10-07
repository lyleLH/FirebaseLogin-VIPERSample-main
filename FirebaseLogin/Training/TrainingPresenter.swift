//
//  TrainingPresenter.swift
//  
//
//  Created by Tom.Liu on .
//
//

import Foundation

protocol TrainingPresenterProtocol: TimerViewControllerDelegate {
    func notifySignInTapped()
    func notifySignUpTapped()
}

class TrainingPresenter: TrainingPresenterProtocol {
    
    private weak var view: TrainingViewProtocol?
    private var router: TrainingRouterProtocol
    private var interactor: TrainingInteractorProtocol
    
    init(view: TrainingViewProtocol? = nil, router: TrainingRouterProtocol, interactor: TrainingInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func notifySignInTapped() {
        router.routeToSignIn(view as! TrainingViewController)
    }
    
    func notifySignUpTapped() {
        router.routeToSignUp(view as! TrainingViewController)
    }
    
    func resetTimerButtonClicked() {
        router.dissMissTrainingPage()
        router.creationModule?.backToCreationFromTraining()
    }
}
