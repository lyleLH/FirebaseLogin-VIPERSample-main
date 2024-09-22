//
//  AuthRepositoryProtocol.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/9/22.
//

import Foundation

protocol AuthRepositoryProtocol: AnyObject {
    func getUserId() -> String?
    func userIsSignedIn() -> Bool
    
    func logOut() throws
    func logIn(data: AuthLogInData, completion: @escaping (Result<AppUser, AuthError>) -> Void)
    func signUp(data: AuthSignUpData, completion: @escaping (Result<AppUser, AuthError>) -> Void)
}
