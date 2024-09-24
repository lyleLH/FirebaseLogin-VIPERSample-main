//
//  SignInEndpoint.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/9/22.
//

import Alamofire
import SwiftyJSON

class SignInEndpoint: Endpoint {
    
    struct Response {
        var refreshToken: String
        var sessionToken: String
        var userId: String
        var salt: String?
    }
    
    let identifier: String, identifierType: String, credential: String, credentialType: String
    
    init(identifier: String, identifierType: String, credential: String, credentialType: String) {
        self.identifier = identifier
        self.identifierType = identifierType
        self.credential = credential
        self.credentialType = credentialType
    }
    
    // MARK: - EndPoint
    
    var result: EndpointResult<Response> = .failed(EndpointError.noResultError)
    
    var path: String {
        return "sign_in"
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var param: [String: Any] {
        return [
            "identifier": identifier,
            "identifier_type": identifierType,
            "credential": credential,
            "credential_type": credentialType
        ]
    }
    
    var shouldAuthenticate: Bool {
        return false
    }
    
    func parseResult(statusCode: Int, json: JSON) {
        if json["success"].boolValue,
            let sessionToken = json["session_token"].string, 
            let userId = json["user_id"].string,
            (json["key"].string != nil),
            let refreshToken = json["refresh_token"].string {
            result = .success(Response(refreshToken: refreshToken, 
                                       sessionToken: sessionToken,
                                       userId: userId,
                                       salt: json["key"].string))
        } else {
            result = .failed(LocalError(title: "Login Failed", description: json["message"].string))
        }
    }
    
}
