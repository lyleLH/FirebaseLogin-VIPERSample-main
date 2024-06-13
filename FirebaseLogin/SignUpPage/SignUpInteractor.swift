//
//  SignUpInteractor.swift
//  FirebaseLogin
//
//  Created by Sezgin on 2.05.2022.
//

import Foundation
import Firebase

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
        FirebaseAuth.Auth.auth().signIn(withEmail: username, password: password) { [weak self] result, error in
            guard let self = self else { return }
            guard error != nil else {
                self.presenter?.userCreateNotSuccess()
                return
            }
            self.showCreateAccount(username: username, password: password)
        }
       
    }
    
    func showCreateAccount(username: String, password: String) {
        FirebaseAuth.Auth.auth().createUser(withEmail: username, password: password) { [weak self] result, error in
            guard let self = self else { return }
            guard error == nil else {
                self.presenter?.userCreateNotSuccess()
                return
            }
            self.presenter?.userCreateSuccess()
        }
    }
}
