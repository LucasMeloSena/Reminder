//
//  UserDefaultsManager.swift
//  Reminder
//
//  Created by Lucas Sena on 14/03/25.
//

import Foundation

class UserDefaultsManager {
    private static let userKey = "userKey"
    
    static func saveUser(user: User) {
        let enconder = JSONEncoder()
        if let encoded = try? enconder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: userKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func loadUser() -> User? {
        if let userData = UserDefaults.standard.data(forKey: userKey) {
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: userData) {
                return user
            }
        }
        return nil
    }
}
