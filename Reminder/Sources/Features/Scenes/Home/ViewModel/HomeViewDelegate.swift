//
//  HomeViewDelegate.swift
//  Reminder
//
//  Created by Lucas Sena on 15/03/25.
//

import Foundation
import UIKit

public protocol HomeViewDelegate: AnyObject {
    func userProfileImageTapped()
    func navigateToMyMedicines()
    func navigateToNewMedicine()
}
