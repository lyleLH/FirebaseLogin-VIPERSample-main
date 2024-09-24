//
//  ApiRequest.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/9/24.
//

import Foundation

protocol ApiRequestProtocol {
    
    static func endpoint<E: Endpoint>(endpoint: E, completion: @escaping (E) -> Void)
}

final class APIRequest: ApiRequestProtocol {
    
    
    static func endpoint<E>(endpoint: E, completion: @escaping (E) -> Void) where E : Endpoint {
         
    }
    
    
}
