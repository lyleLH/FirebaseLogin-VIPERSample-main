//
//  SignUpInteractor.swift
//  FirebaseLogin
//
//  Created by Sezgin on 2.05.2022.
//

import Foundation

protocol SignUpInteractorProtocol {
    func didCreateUser(username: String, password: String)
    func didOpenAuth2CreateUser()
}

class SignUpInteractor: SignUpInteractorProtocol {
    func didOpenAuth2CreateUser() {
        Task {
            do {
                try await Appwrite.shared.onOAuth2Regist()
            } catch {
                
            }
        }
    }
    
    
    weak var presenter: SignUpPresenterProtocol?
    
    func didCreateUser(username: String, password: String) {
        
        Task {
            do {
                try await Appwrite.shared.onRegister(username, password)
                DispatchQueue.main.async {
                    self.presenter?.userCreateSuccess()
                }
            } catch { error
                debugPrint(error)
                DispatchQueue.main.async {
                    self.presenter?.userCreateNotSuccess()
                    
                }
                
                
            }
        }
    }
    
}
