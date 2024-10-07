//
//  SignInInteractorTests.swift
//  FirebaseLoginTests
//
//  Created by Tom.Liu on 2024/9/30.
//

import Foundation
import XCTest

class SignInInteractorTests: XCTestCase {

//    
//    var interactor: SignInInteractor!
//    var mockAppwrite: MockAppwrite!
//
//    override func setUp() {
//        super.setUp()
//        mockAppwrite = MockAppwrite()
////        Appwrite.shared = mockAppwrite // Assuming Appwrite has a shared instance
//        interactor = SignInInteractor()
//    }
//
//    override func tearDown() {
//        interactor = nil
//        mockAppwrite = nil
//        super.tearDown()
//    }
//
//    func testDidFetchUser_SuccessWithSession() async {
//        mockAppwrite.session = "existingSession"
//        
//        let result = await interactor.didFetchUser(username: "testUser", password: "testPassword")
//        
//        switch result {
//        case .success(let success):
//            XCTAssertTrue(success)
//        case .failure:
//            XCTFail("Expected success but got failure")
//        }
//    }
//
//    func testDidFetchUser_SuccessWithoutSession() async {
//        mockAppwrite.session = nil
//        
//        let result = await interactor.didFetchUser(username: "testUser", password: "testPassword")
//        
//        switch result {
//        case .success(let success):
//            XCTAssertTrue(success)
//            XCTAssertNotNil(mockAppwrite.session) // Ensure session is set after login
//        case .failure:
//            XCTFail("Expected success but got failure")
//        }
//    }
//
//    func testDidFetchUser_FailureOnLogin() async {
//        mockAppwrite.shouldFailOnLogin = true
//        
//        let result = await interactor.didFetchUser(username: "testUser", password: "testPassword")
//        
//        switch result {
//        case .success:
//            XCTFail("Expected failure but got success")
//        case .failure(let error):
//            XCTAssertEqual((error as NSError).domain, "LoginError")
//        }
//    }
//
//    func testDidLoginByOauth2_Success() async {
//        let result = await interactor.didLoginByOauth2()
//        
//        switch result {
//        case .success(let success):
//            XCTAssertTrue(success)
//        case .failure:
//            XCTFail("Expected success but got failure")
//        }
//    }
//
//    func testDidLoginByOauth2_Failure() async {
//        mockAppwrite.shouldFailOnOAuth2 = true
//        
//        let result = await interactor.didLoginByOauth2()
//        
//        switch result {
//        case .success:
//            XCTFail("Expected failure but got success")
//        case .failure(let error):
//            XCTAssertEqual((error as NSError).domain, "OAuth2Error")
//        }
//    }
}
