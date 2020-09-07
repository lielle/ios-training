//
//  EmployeeDao.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/3/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation

class EmployeeDao: Codable {
    
    var employee: Employee
    
    init(employee: Employee) {
        self.employee = employee
    }
    
    func insert() {
        let query = "INSERT INTO employee(name, companyId, positionId, contact, address, logo) VALUES (?, ?, ?, ?, ?, ?);"
        let params: [Any] = [
            employee.name,
            employee.companyId,
            employee.positionId,
            employee.contact,
            employee.address,
            employee.logoKey,
            
        ]
        DatabaseHelper.shared.insert(query: query, params: params)
    }
    
    func update() {
        let query = "UPDATE employee SET name = ?, positionId = ?, contact = ?, address = ? WHERE id = ?;"
        let params: [Any] = [
            employee.name,
            employee.positionId,
            employee.contact,
            employee.address,
            employee.id ?? 0
        ]
        DatabaseHelper.shared.update(query: query, params: params)
    }
    
    func delete() {
        let query = "DELETE FROM employee WHERE id = ?;"
        let params: [Any] = [
            employee.id!
        ]
        DatabaseHelper.shared.delete(query: query, params: params)
    }
    
}

// MARK: - Static functions
extension EmployeeDao {
    
    static func fetchEmployees(of companyId: Int) -> [Employee] {
        return filterEmployees(of: companyId)
    }
    
    static func filterEmployees(of companyId: Int, by positionId: Int? = nil, keyword: String? = nil) -> [Employee] {
        var query: String
        var params: [Any]
        
        if let positionId = positionId, let keyword = keyword {
            // filter by position and keyword
            query = "SELECT id, name, companyId, positionId, contact, address, logo FROM employee WHERE companyId=? AND positionId=? AND name LIKE ?;"
            params = [companyId, positionId, "%\(keyword)%"]
        } else if let positionId = positionId {
            // filter by position
            query = "SELECT id, name, companyId, positionId, contact, address, logo FROM employee WHERE companyId=? AND positionId=?;"
            params = [companyId, positionId]
        } else if let keyword = keyword {
            // filter by keyword
            query = "SELECT id, name, companyId, positionId, contact, address, logo FROM employee WHERE companyId=? AND name LIKE ?;"
            params = [companyId, "%\(keyword)%"]
        } else {
            // no filter
            query = "SELECT id, name, companyId, positionId, contact, address, logo FROM employee WHERE companyId=?;"
            params = [companyId]
        }
        
        let columnTypes: [Any.Type] = [Int.self, String.self, Int.self, Int.self, String.self, String.self, String.self]
        
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
