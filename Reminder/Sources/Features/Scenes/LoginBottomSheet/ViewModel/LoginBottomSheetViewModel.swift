//
//  LoginBottomSheetViewModel.swift
//  Reminder
//
//  Created by Lucas Sena on 13/03/25.
//

import Foundation
import Firebase

class LoginBottomSheetViewModel {
    var didFinishedAuth: ((String) -> Void)?
    var error: ((String) -> Void)?
    
     func doAuth(email: String, password: String) {
         Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
             if let error = error {
                 self?.error?("Credenciais inválidas.")
             } else {
                 self?.didFinishedAuth?(email)
             }
         }
    }
}
