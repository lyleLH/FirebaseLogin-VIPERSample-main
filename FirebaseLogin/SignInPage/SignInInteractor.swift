//
//  SignInInteractor.swift
//  FirebaseLogin
//
//  Created by Sezgin on 1.05.2022.
//

import Foundation

protocol SignInInteractorProtocol {
    
    func didFetchUser(username: String, password: String) async throws -> Result<Bool, Error>
    func didLoginByOauth2() async throws -> Result<Bool, Error>
    
}

class SignInInteractor: SignInInteractorProtocol {

    func didLoginByOauth2() async throws -> Result<Bool, Error> {
        do {
            try await Appwrite.shared.onOAuth2Regist()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }

    func didFetchUser(username: String, password: String) async throws -> Result<Bool, Error> {
        do {
            if let _ = Appwrite.shared.session {
                return .success(true)
            } else {
                _ = try await Appwrite.shared.onLogin(username, password)
                return .success(true)
            }
        } catch {
            debugPrint(error)
            return .failure(error)
        }
    }
    
}
