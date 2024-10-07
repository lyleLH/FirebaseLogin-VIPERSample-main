import Foundation
import Appwrite
import JSONCodable
import DateHelper

let pId = "666a5e7b0004c231ffda"

protocol UserServerSateProtocol: NSObject {
    func isUserLoggin(sessionId: String) async throws -> Bool
}

class Appwrite: NSObject, UserServerSateProtocol {
  
    static let shared = Appwrite()
    
    var client: Client
    var account: Account
    var session: Session?
    
    private override init() {
        self.client = Client()
            .setEndpoint("https://cloud.appwrite.io/v1")
            .setProject(pId)
        
        self.account = Account(client)
    }
    
    func isUserLoggin(sessionId: String) async throws -> Bool {
        let session = try await account.getSession(sessionId: sessionId)
        if let expireDate = Date(fromString: session.expire, format: Date.DateFormatType.isoDateTimeFull),
           expireDate.compare(Date()) == .orderedAscending {
            return false
        } else {
            LocalDataManager.shared.saveSessionId(sessionId)
            return true
        }
    }
    
    func onRegister(
        _ email: String,
        _ password: String
    ) async throws -> User<[String: AnyCodable]> {
        try await account.create(
            userId: ID.unique(),
            email: email,
            password: password
        )
    }
    
    func onLogin(
        _ email: String,
        _ password: String
    ) async throws -> Session? {
       
        do {
            let session =  try await account.createEmailPasswordSession(
                email: email,
                password: password
           )
               self.session = session
               return session
        } catch {
            if let error = error as? AppwriteError {
                throw LocalError(title: error.type, description: error.message)
            } else {
                throw error
            }
        }
    }
    
    func onLogout() async throws {
        _ = try await account.deleteSession(
            sessionId: "current"
        )
        self.session = nil
    }
    
    func onOAuth2Regist() async throws {
        // Go to OAuth provider login page
        _ =  try await account.createOAuth2Session(
            provider: .google,
            scopes: ["profile"]
        )
    }
}
