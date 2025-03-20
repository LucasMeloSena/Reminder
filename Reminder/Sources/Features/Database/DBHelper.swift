//
//  DBHelper.swift
//  Reminder
//
//  Created by Lucas Sena on 18/03/25.
//

import Foundation
import SQLite3

class DBHelper {
    static let shared = DBHelper()
    private var db: OpaquePointer?
    
    private init() {
        openDatabase()
        createTable()
    }
    
    private func openDatabase() {
        let fileUrl = try? FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("Reminder.sqlite")
        
        if (sqlite3_open(fileUrl?.path, &db) != SQLITE_OK) {
            print("Error when opening database")
        }
    }
    
    private func createTable() {
        let createTableQuery = """
            CREATE TABLE IF NOT EXISTS Medicines (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT,
                time TEXT,
                recurrence TEXT,
                takeNow INTEGER
            ); 
        """
        
        var statement: OpaquePointer?
        if (sqlite3_prepare_v2(db, createTableQuery, -1, &statement, nil) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                print("Created Medicines TABLE successfully.")
            } else {
                print("Error creating Medicines TABLE.")
            }
        } else {
            print("Error executing statement")
        }
        
        sqlite3_finalize(statement)
    }
    
    func insertMedicine(medicine: Medicine) {
        let insertQuery = """
            INSERT INTO Medicines (
                name,
                time,
                recurrence,
                takeNow
            ) VALUES (
                ?,
                ?,
                ?,
                ? 
            );
        """
        var statement: OpaquePointer?
        
        if (sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK) {
            sqlite3_bind_text(statement, 1, (medicine.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (medicine.time as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (medicine.recurrence as NSString).utf8String, -1, nil)
            sqlite3_bind_int(statement, 4, (medicine.takeNow ? 1 : 0))
            
            if (sqlite3_step(statement) == SQLITE_DONE) {
                print("Inserted into Medicines successfully.")
            } else {
                print("Error inserting in Medicines TABLE.")
            }
        } else {
            print("Error executing statement")
        }
        
        sqlite3_finalize(statement)
    }
    
    func fecthMedicines() -> [Medicine] {
        let fetchQuery = "SELECT * FROM Medicines"
        var statement: OpaquePointer?
        var medicines: [Medicine] = []
        
        if (sqlite3_prepare_v2(db, fetchQuery, -1, &statement, nil) == SQLITE_OK) {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let name = sqlite3_column_text(statement, 1).flatMap { String(cString: $0) } ?? "Unknow"
                let time = sqlite3_column_text(statement, 2).flatMap { String(cString: $0) } ?? "Unknow"
                let recurrence = sqlite3_column_text(statement, 3).flatMap { String(cString: $0) } ?? "Unknow"
                let takeNow = sqlite3_column_int(statement, 4) == 1
                
                let medicine = Medicine(id: id, name: name, time: time, recurrence: recurrence, takeNow: takeNow)
                medicines.append(medicine)
            }
            if (sqlite3_step(statement) != SQLITE_DONE) {
                print("Error searching medicines")
            }
        } else {
            print("Erro executing statement")
        }
        sqlite3_finalize(statement)
        
        return medicines
    }
    
    func deleteQuery(byId id: Int) {
        let deleteQuery = """
            DELETE FROM Medicines WHERE id = ?;
        """
        var statement: OpaquePointer?
        
        if (sqlite3_prepare_v2(db, deleteQuery, -1, &statement, nil) == SQLITE_OK) {
            sqlite3_bind_int(statement, 1, Int32(id))
            
            if (sqlite3_step(statement) != SQLITE_DONE) {
                print("Error deleting medicine")
            }
        } else {
            print("Error executing statement")
        }
        
        sqlite3_finalize(statement)
    }
}
