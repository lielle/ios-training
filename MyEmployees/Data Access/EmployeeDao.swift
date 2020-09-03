//
//  EmployeeDao.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/3/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation

class EmployeeDao {
    
    static func insert(employee: Employee) {
        let query = "INSERT INTO employee(name, companyId, positionId, contact, address, logo) VALUES (?, ?, ?, ?, ?, ?);"
        let params: [Any] = [
            employee.name!,
            employee.companyId!,
            employee.positionId!,
            employee.contact!,
            employee.address!,
            employee.logoKey!,
            
        ]
        DatabaseHelper.shared.insert(query: query, params: params)
    }
    
    static func fetchEmployees(of companyId: Int) -> [Employee] {
        return searchEmployees(of: companyId, keyword: "")
    }
    
    static func searchEmployees(of companyId: Int, keyword: String) -> [Employee] {
        let query = "SELECT id, name, companyId, positionId, contact, address, logo FROM employee WHERE companyId=? AND name LIKE ?;"
        let columnTypes: [Any.Type] = [Int.self, String.self, Int.self, Int.self, String.self, String.self, String.self]
        let params: [Any] = [companyId, "%\(keyword)%"]
        
        guard let response = DatabaseHelper.shared.fetch(query: query, columnTypes: columnTypes, params: params) else {
            return []
        }
        
        var employees: [Employee] = []
        for i in 0..<response.count {
            let companyFields = response[i]
            let id = companyFields[0] as! Int
            let name = companyFields[1] as! String
            let companyId = companyFields[2] as! Int
            let positionId = companyFields[3] as! Int
            let contact = companyFields[4] as! String
            let address = companyFields[5] as! String
            let logoKey = companyFields[6] as! String
            let employee = Employee(id: id, companyId: companyId, name: name, positionId: positionId, contact: contact, address: address, logoKey: logoKey)
            employees.append(employee)
        }
        
        return employees
    }
    
    static func filterEmployees(of companyId: Int, by positionId: Int) -> [Employee] {
        let query = "SELECT id, name, companyId, positionId, contact, address, logo FROM employee WHERE companyId=? AND positionId=?;"
        let columnTypes: [Any.Type] = [Int.self, String.self, Int.self, Int.self, String.self, String.self, String.self]
        let params = [companyId, positionId]
        
        guard let response = DatabaseHelper.shared.fetch(query: query, columnTypes: columnTypes, params: params) else {
            return []
        }
        
        var employees: [Employee] = []
        for i in 0..<response.count {
            let companyFields = response[i]
            let id = companyFields[0] as! Int
            let name = companyFields[1] as! String
            let companyId = companyFields[2] as! Int
            let positionId = companyFields[3] as! Int
            let contact = companyFields[4] as! String
            let address = companyFields[5] as! String
            let logoKey = companyFields[6] as! String
            let employee = Employee(id: id, companyId: companyId, name: name, positionId: positionId, contact: contact, address: address, logoKey: logoKey)
            employees.append(employee)
        }
        
        return employees
    }
    
}
