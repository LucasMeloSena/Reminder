//
//  NewMedicineFlowDelegate.swift
//  Reminder
//
//  Created by Lucas Sena on 16/03/25.
//

import Foundation
import UIKit

protocol NewMedicineFlowDelegate: AnyObject {
    func navigateToNewMedicine()
    func navigateToHomeFromNewMedicine()
}
