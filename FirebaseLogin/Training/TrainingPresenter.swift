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
    
    weak var view: TrainingViewProtocol?
    var router: TrainingRouterProtocol?
    var interactor: TrainingInteractorProtocol?
    
    func notifySignInTapped() {
        router?.routeToSignIn(view as! TrainingViewController)
    }
    
    func notifySignUpTapped() {
        router?.routeToSignUp(view as! TrainingViewController)
    }
    
    func resetTimerButtonClicked() {
        router?.dissMissTrainingPage()
        router?.creationModule?.backToCreationFromTraining()
    }
}
