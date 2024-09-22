//
//  AppUser.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/9/22.
//

import Foundation

struct AppUser {
    var id: String
    var username: String
    var email: String
    var dateOfBirth: Date?
    var sex: Sex?
    var pictureUrl: String?
}

enum Sex: Int, CaseIterable {
    case male
    case female
    
    var name: String {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        }
    }
}
