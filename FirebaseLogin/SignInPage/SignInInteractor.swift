//
//  SignInInteractor.swift
//  FirebaseLogin
//
//  Created by Sezgin on 1.05.2022.
//

import Foundation

protocol SignInInteractorProtocol {
    func didFetchUser(username: String, password: String)
    func didLoginByOauth2()
    
}

class SignInInteractor: SignInInteractorProtocol {
    func didLoginByOauth2() {
        Task {
            do {
                try await Appwrite.shared.onOAuth2Regist()
                self.presenter?.signInSuccess()
            }
            catch {
                self.presenter?.signInNotSuccess()
            }
        }
    }
    
    
    weak var presenter: SignInPresenterProtocol?
    
    func didFetchUser(username: String, password: String) {
        
        Task {
            do {
                if let _ = Appwrite.shared.session  {
                    self.presenter?.signInSuccess()
                } else {
                    _ = try await Appwrite.shared.onLogin(username, password)
                    
                    self.presenter?.signInSuccess()
                }
            } catch { error
                debugPrint(error)
                DispatchQueue.main.async {
                    self.presenter?.signInNotSuccess()
                    
                }
            }
        }
 
    }
}
