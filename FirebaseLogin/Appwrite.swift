import Foundation
import Appwrite
import JSONCodable

let pId = "666a5e7b0004c231ffda"

class Appwrite {
    static let shared = Appwrite()
    
    var client: Client
    var account: Account
    var session: Session?
    
    private init() {
        self.client = Client()
            .setEndpoint("https://cloud.appwrite.io/v1")
            .setProject(pId)
        
        self.account = Account(client)
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
    ) async throws -> Session {
       let session =  try await account.createEmailPasswordSession(
            email: email,
            password: password
        )
        self.session = session
        return session
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
