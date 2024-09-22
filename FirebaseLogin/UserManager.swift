//
//  UserManager.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/6/13.
//

import Foundation

enum UserSate: String {
    
    case firstLaunch = "first_launch"
    case signedIn = "login"
    case signedOut = "signed_out"

}

class UserManager {
    
    static let shared = UserManager()
    
    weak var webService: UserServerSateProtocol?
    weak var locaDataManager: LocalDataManagerProtocol?
    
    private init() {
         
    }
    
    func getUserState() async throws -> UserSate {
        if let sessionId = locaDataManager?.getSessionIds()?.first {
            if try await webService?.isUserLoggin(sessionId: sessionId) == true {
                return .signedIn
            }
        }
        return .signedOut
    }
       
}
