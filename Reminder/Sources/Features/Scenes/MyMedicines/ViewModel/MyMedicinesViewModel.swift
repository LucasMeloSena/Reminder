//
//  MyMedicinesViewModel.swift
//  Reminder
//
//  Created by Lucas Sena on 20/03/25.
//

import Foundation

class MyMedicinesViewModel {
    func fetchData() -> [Medicine] {
        return DBHelper.shared.fecthMedicines()
    }
    
    func deleteMedicine(byId id: Int) {
        return DBHelper.shared.deleteQuery(byId: id)
    }
}
