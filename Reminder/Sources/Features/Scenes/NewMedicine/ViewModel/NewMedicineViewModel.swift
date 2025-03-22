//
//  NewMedicineViewModel.swift
//  Reminder
//
//  Created by Lucas Sena on 18/03/25.
//

import Foundation
import UserNotifications

let ONE_HOUR_IN_SECONDS = 60.0 * 60.0

class NewMedicineViewModel {
    func addMedicine(medicine: Medicine) {
        DBHelper.shared.insertMedicine(medicine: medicine)
        scheduleNotifications(medicine: medicine)
    }
    
    private func scheduleNotifications(medicine: Medicine) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        content.title = "Reminder"
        content.body = "Está na hora de tomar o \(medicine.name)"
        content.sound = .default
        
        guard let interval = getIntervalInHours(from: medicine.recurrence) else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        guard let initialDate = formatter.date(from: medicine.time) else { return }
        let calendar = Calendar.current
        var currentDate = initialDate
        
        for i in 0..<Int(24 / interval) {
            let components = calendar.dateComponents([.hour, .minute], from: currentDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            
            let request = UNNotificationRequest(identifier: "\(medicine.name)-\(i)", content: content, trigger: trigger)
            center.add(request) { error in
                if let error = error {
                    print("Erro ao agendar notificações, \(error)")
                } else {
                    print("Notificação para \(medicine.name) criada com sucesso")
                }
            }
            currentDate = calendar.date(byAdding: .hour, value: Int(interval), to: currentDate) ?? Date()
        }
    }
    
    private func getIntervalInHours(from recurrence: String) -> Double? {
        switch (recurrence) {
        case "1/1":
            return 1.0
        case "2/2":
            return 2.0
        case "4/4":
            return 4.0
        case "6/6":
            return 6.0
        case "8/8":
            return 8.0
        case "12/12":
            return 12.0
        case "24/24":
            return 24.0
        default:
            return nil
        }
    }
}
