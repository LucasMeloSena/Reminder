//
//  LoginBottomSheetViewDelegate.swift
//  Reminder
//
//  Created by Lucas Sena on 13/03/25.
//

import Foundation
import UIKit

protocol LoginBottomSheetViewDelegate: AnyObject {
    func sendLoginData(email: String, password: String)
}
