//
//  UserDefaultsManager.swift
//  Reminder
//
//  Created by Lucas Sena on 14/03/25.
//

import Foundation
import UIKit

class UserDefaultsManager {
    private static let userKey = "userKey"
    private static let usernameKey = "usernameKey"
    private static let userImageKey = "userImageKey"
    
    static func saveUser(user: User) {
        let enconder = JSONEncoder()
        if let encoded = try? enconder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: userKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func saveUsername(name: String) {
        UserDefaults.standard.set(name, forKey: usernameKey)
        UserDefaults.standard.synchronize()
    }
    
    static func saveUserImage(image: UIImage) {
        UserDefaults.standard.set(image.pngData(), forKey: userImageKey)
        UserDefaults.standard.synchronize()
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
    
    static func loadUsername() -> String? {
        if let username = UserDefaults.standard.string(forKey: usernameKey) {
            return username
        } else {
            return nil
        }
    }
    
    static func loadUserImage() -> UIImage? {
        if let imageData = UserDefaults.standard.data(forKey: userImageKey) {
            return UIImage(data: imageData)
        } else {
            return nil
        }
    }
    
    static func deleteUserImage() {
        UserDefaults.standard.removeObject(forKey: userImageKey)
        UserDefaults.standard.synchronize()
    }
    
    static func deleteUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
        UserDefaults.standard.synchronize()
    }
    
    static func deleteUsername() {
        UserDefaults.standard.removeObject(forKey: usernameKey)
        UserDefaults.standard.synchronize()
    }
}
