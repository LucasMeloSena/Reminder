//
//  NewMedicineViewModel.swift
//  Reminder
//
//  Created by Lucas Sena on 18/03/25.
//

import Foundation

class NewMedicineViewModel {
    func addMedicine(medicine: Medicine) {
        DBHelper.shared.insertMedicine(medicine: medicine)
    }
}
