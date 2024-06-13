//
//  MainPresenter.swift
//  FirebaseLogin
//
//  Created by Sezgin on 9.05.2022.
//

import Foundation

protocol MainPresenterProtocol {
    func displayAlert(_ messaege: String)
    func displayUserName(_ name: String) 
    func getTopNewsDataUs(_ dataModel: [Article])
    func routeToDetail(_ urlString: String)
    
    func notifyPresenterForTr()
    func notifyPresenterForUs()
    func showProfileButtonClickeEvent()
}

class MainPresenter: MainPresenterProtocol {
    
    var urlString: String = ConstantsApi.baseUrl+ConstantsApi.countryUs+ConstantsApi.apiKey
    
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol?
    var interactor: MainInteractorProtocol? {
        didSet {
            guard let url = URL(string: urlString) else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.interactor?.fetchNewsData(url: url)
            }
        }
    }
    
    func notifyPresenterForTr() {
        urlString = ConstantsApi.baseUrl+ConstantsApi.countryTr+ConstantsApi.apiKey
        guard let url = URL(string: urlString) else { return }
        interactor?.fetchNewsData(url: url)
    }
    
    func notifyPresenterForUs() {
        urlString = ConstantsApi.baseUrl+ConstantsApi.countryUs+ConstantsApi.apiKey
        guard let url = URL(string: urlString) else { return }
        interactor?.fetchNewsData(url: url)
    }
    
    func showProfileButtonClickeEvent() {
        interactor?.getUserProfile()
    }
    
    func getTopNewsDataUs(_ dataModel: [Article]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.updateData(with: dataModel)
        }
    }
    
    func displayAlert(_ messaege: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.updateData(with: messaege)
        }
    }
    
    func displayUserName(_ name: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.showProfileName(name: name)
        }
    }
    
    func routeToDetail(_ urlString: String) {
        self.router?.routeToDetail(urlString, view as! MainViewController)
    }
}
