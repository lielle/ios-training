//
//  DatabaseHelper.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 8/21/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation
import SQLite3

class DatabaseHelper {
    
    static let shared: DatabaseHelper = DatabaseHelper()
    
    init() {
        db = openDatabase()
        createCompanyTable()
    }
    
    let dbPath = "MyEmployees.sqlite"
    var db: OpaquePointer?
    
    func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening database")
            return nil
        } else {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
}

// MARK: - CREATE TABLES
extension DatabaseHelper {
    
    func createCompanyTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS company(id INTEGER PRIMARY KEY, name TEXT, username TEXT, password TEXT, contact TEXT, address TEXT, logo TEXT);"
        var createTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Company table created.")
            } else {
                print("Company table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        
        sqlite3_finalize(createTableStatement)
    }
    
}

// MARK: - INSERT QUERIES
extension DatabaseHelper {
    
    func insert(company: Company) {
        let insertStatementString = "INSERT INTO company(name, username, password, contact, address, logo) VALUES (?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(insertStatement, 1, (company.name! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (company.username! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (company.password! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (company.contact! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (company.address! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (company.logoKey! as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted company.")
            } else {
                print("Could not insert company.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
}

// MARK: - FETCH QUERIES
extension DatabaseHelper {
    
    func fetchCompanyPasswordBy(username: String) -> String? {
        let queryStatementString = "SELECT password FROM company WHERE username=?;"
        var queryStatement: OpaquePointer? = nil
        var password: String? = nil
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(queryStatement, 1, (username as NSString).utf8String, -1, nil)
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
                password = String(cString: sqlite3_column_text(queryStatement, 0))
                
                print("Query Result:")
                print("\(String(describing: password))")
            }
            
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        
        return password
    }
    
    func fetchCompanyBy(username: String) -> Company? {
        let queryStatementString = "SELECT id, name, username, password, contact, address, logo FROM company WHERE username=?;"
        var queryStatement: OpaquePointer? = nil
        var company: Company? = nil
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(queryStatement, 1, (username as NSString).utf8String, -1, nil)
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
                let id = Int(sqlite3_column_int(queryStatement, 0))
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                let username = String(cString: sqlite3_column_text(queryStatement, 2))
                let password = String(cString: sqlite3_column_text(queryStatement, 3))
                let contact = String(cString: sqlite3_column_text(queryStatement, 4))
                let address = String(cString: sqlite3_column_text(queryStatement, 5))
                let logo = String(cString: sqlite3_column_text(queryStatement, 6))
                
                print("Query Result:")
                print("\(id)")
                
                company = Company(id: id, name: name, username: username, password: password, contact: contact, address: address, logoKey: logo)
            }
            
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        
        return company
    }
    
}
