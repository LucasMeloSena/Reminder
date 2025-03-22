//
//  MyMedicinesViewModel.swift
//  Reminder
//
//  Created by Lucas Sena on 20/03/25.
//

import Foundation
import UserNotifications

class MyMedicinesViewModel {
    func fetchData() -> [Medicine] {
        return DBHelper.shared.fecthMedicines()
    }
    
    func deleteMedicine(byId id: Int) {
        return DBHelper.shared.deleteQuery(byId: id)
    }
    
    func removeNofitifications(for medicine: String) {
        let center = UNUserNotificationCenter.current()
        let identifiers = (0..<Int(6)).map {"\(medicine)-\($0)"}
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
        print("Notificações para \(medicine) removidas")
    }
}
