//
//  LocalDataManager.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/6/15.
//

import Foundation
import RealmSwift
protocol LocalDataManagerProtocol: NSObject {
    
    func getSessionIds() -> [String]?
    
    
}


class SessionObject: Object {
    @Persisted var sesseionId: String

}

class LocalDataManager: NSObject, LocalDataManagerProtocol {
    
    static let shared = LocalDataManager()

    
    func getSessionIds() -> [String]? {
            do {
                let realm = try Realm()
                let sessionObjects = realm.objects(SessionObject.self).map { obj in
                    obj.sesseionId
                }
                return Array(sessionObjects)
            } catch {
                print("Error retrieving session ids: \(error)")
                return nil
            }
        }
    
    func saveSessionId(_ sesseionId: String) {
        let sessionObj = SessionObject()
        sessionObj.sesseionId = sesseionId
        let realm = try! Realm()
        try! realm.write {
            realm.add(sessionObj)
        }
    }
    
}
