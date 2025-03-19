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
}
