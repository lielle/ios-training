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
        createTables()
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
    
    func createTable(query: String) {
        let createTableString = query
        var createTableStatement: OpaquePointer? = nil
        print(query)
        
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Table created.")
            } else {
                print("Table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        
        sqlite3_finalize(createTableStatement)
    }
    
    func createTables() {
        createTable(query: "CREATE TABLE IF NOT EXISTS company(id INTEGER PRIMARY KEY, name TEXT, username TEXT, password TEXT, contact TEXT, address TEXT, logo TEXT);")
        createTable(query: "CREATE TABLE IF NOT EXISTS employee(id INTEGER PRIMARY KEY, companyId INTEGER, name TEXT, positionId INTEGER, contact TEXT, address TEXT, logo TEXT);")
    }
    
}

// MARK: - MODIFY QUERIES
extension DatabaseHelper {
    
    func insert(query: String, params: [Any]) {
        let insertStatementString = query
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            // add params
            for (index, param) in params.enumerated() {
                if param is String {
                    sqlite3_bind_text(insertStatement, Int32(index+1), (param as! NSString).utf8String, -1, nil)
                } else if param is Int {
                    sqlite3_bind_int(insertStatement, Int32(index+1), Int32(truncating: param as! NSNumber))
                }
            }
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Insert: \(query)")
            } else {
                print("Could not insert \(query)")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func update(query: String, params: [Any]) {
        
        let updateStatementString = query
        var updateStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            
            // add params
            for (index, param) in params.enumerated() {
                if param is String {
                    sqlite3_bind_text(updateStatement, Int32(index+1), (param as! NSString).utf8String, -1, nil)
                } else if param is Int {
                    sqlite3_bind_int(updateStatement, Int32(index+1), Int32(truncating: param as! NSNumber))
                }
            }
            
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Update: \(query), params: \(params)")
            } else {
                print("Could not updated row.")
            }
        } else {
            print("UPDATE statement could not be prepared.")
        }
        sqlite3_finalize(updateStatement)
    }
    
    func delete(query: String, params: [Any]) {
        let deleteStatementString = query
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            
            // add params
            for (index, param) in params.enumerated() {
                if param is String {
                    sqlite3_bind_text(deleteStatement, Int32(index+1), (param as! NSString).utf8String, -1, nil)
                } else if param is Int {
                    sqlite3_bind_int(deleteStatement, Int32(index+1), Int32(truncating: param as! NSNumber))
                }
            }
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Delete: \(query), params: \(params)")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
}

// MARK: - FETCH QUERIES
extension DatabaseHelper {
    
    func fetch(query: String, columnTypes: [Any.Type], params: [Any]) -> [[Any?]]? {
        let queryStatementString = query
        var queryStatement: OpaquePointer? = nil
        var rows: [[Any?]] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            // add params
            for (index, param) in params.enumerated() {
                if param is String {
                    sqlite3_bind_text(queryStatement, Int32(index+1), (param as! NSString).utf8String, -1, nil)
                } else if param is Int {
                    sqlite3_bind_int(queryStatement, Int32(index+1), Int32(truncating: param as! NSNumber))
                }
            }
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                var columns: [Any?] = []
                for columnIndex in 0..<columnTypes.count {
                    var column: Any? = nil
                    
                    if columnTypes[columnIndex] == String.self {
                        column = String(cString: sqlite3_column_text(queryStatement, Int32(columnIndex)))
                    } else if columnTypes[columnIndex] == Int.self {
                        column = Int(sqlite3_column_int(queryStatement, Int32(columnIndex)))
                    }
                    
                    columns.append(column)
                }
                rows.append(columns)
            }
            print("Fetch: \(query), params: \(params)")
            
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        
        let response = rows.count>0 ? rows : nil
        print(response ?? "Null response")
        return response
    }
    
}
