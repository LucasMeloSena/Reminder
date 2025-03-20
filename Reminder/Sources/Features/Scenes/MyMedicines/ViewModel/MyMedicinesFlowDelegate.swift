//
//  MyMedicinesFlowDelegate.swift
//  Reminder
//
//  Created by Lucas Sena on 18/03/25.
//

import Foundation

protocol MyMedicinesFlowDelegate: AnyObject {
    func navigateToMyMedicines()
    func navigateToNewMedicine()
    func navigateToHomeFromNewMedicine()
}
