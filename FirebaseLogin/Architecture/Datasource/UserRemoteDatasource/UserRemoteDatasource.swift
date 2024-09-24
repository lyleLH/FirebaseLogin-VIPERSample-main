//
//  UserRemoteDatasource.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/9/24.
//

import Foundation


protocol UserRemoteDatasourceProtocol {
    
}

final class UserRemoteDatasource {
    
    private var apiRequest: ApiRequestProtocol
    
    init(apiRequest: ApiRequestProtocol) {
        self.apiRequest = apiRequest
    }
}
