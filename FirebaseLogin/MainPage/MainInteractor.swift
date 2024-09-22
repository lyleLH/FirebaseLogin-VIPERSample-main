//
//  MainInteractor.swift
//  FirebaseLogin
//
//  Created by Sezgin on 9.05.2022.
//

import Foundation
import AppwriteModels

protocol MainInteractorProtocol {
    func fetchNewsData(url: URL)
    func getUserProfile()
}

class MainInteractor: MainInteractorProtocol {
    
    func getUserProfile() {
        Task {
            do {
                let user: User = try await Appwrite.shared.account.get()
                self.presenter?.displayUserName(user.name)
            } catch { error
                debugPrint(error)
            }
        }
    }
    
    var presenter: MainPresenterProtocol?
    
    func fetchNewsData(url: URL) {
                        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            guard let data = data, error == nil else {
                self.presenter?.displayAlert("Domain Error!")
                return
            }
            let result = try? JSONDecoder().decode(MainEntity.self, from: data)
            if let result = result {
                self.presenter?.getTopNewsDataUs(result.articles ?? [])
            } else {
                self.presenter?.displayAlert("Decoding Error!")
            }
        }.resume()
    }
}
