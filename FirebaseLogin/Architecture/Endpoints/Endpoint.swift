//
//  Endpoint.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/9/22.
//

import SwiftyJSON
import Alamofire

struct EndpointError {
    // swiftlint:disable line_length
    static let noResultError = LocalError(title: "No Result Error", description: "Request has not been fired.")
    static let noNetworkError = LocalError(title: "Network Not Available", description: "Please retry after making sure that your network is available.")
    static let unauthorizedError = LocalError(title: "Invalid Credential", description: "Please sign in again.")
    static let serviceUnavailable = LocalError(title: "Service Unavailable", description: "We have issue connecting to the server.")
    static let notFoundError = LocalError(title: "Not found Error", description: "A 404 error from the server.")
    static let serverUnexpectedError = LocalError(title: "Service Unavailable", description: "We have issue connecting to the server.")
    // swiftlint:enable line_length 
}

enum EndpointResult<Response> {
    case success(Response)
    case failed(LocalError?)
}

/// An endpoint protocal is responsible for generating the request, verifying the request parameter is valid and parse the result.
protocol Endpoint: AnyObject {
    
    associatedtype Response
    
    var result: EndpointResult<Self.Response> { get set }
    
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var param: [String: Any] { get }
    
    var shouldAuthenticate: Bool { get }
    
    func parseResult(statusCode: Int, json: JSON)
}

protocol UploadEndpoint: Endpoint {
    
    associatedtype Response
    
    var fileNames: [String] { get }
    
    var mimeTypes: [String] { get }
    
    var data: [Data] { get }
    
}

extension UploadEndpoint {
    
    var method: HTTPMethod {
        return .post
    }
    
    var shouldAuthenticate: Bool {
        return true
    }
    
}
