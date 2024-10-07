//
//  MockAppwrite.swift
//  FirebaseLoginTests
//
//  Created by Tom.Liu on 2024/9/30.
//

import XCTest

class MockAppwrite {
    var session: String? // Simulate session state
    var shouldFailOnLogin = false
    var shouldFailOnOAuth2 = false

    func onLogin(_ username: String, _ password: String) async throws {
        if shouldFailOnLogin {
            throw NSError(domain: "LoginError", code: 1, userInfo: nil)
        }
        // Simulate successful login
        session = "mockSession"
    }

    func onOAuth2Regist() async throws {
        if shouldFailOnOAuth2 {
            throw NSError(domain: "OAuth2Error", code: 1, userInfo: nil)
        }
        // Simulate successful OAuth2 registration
    }
}
